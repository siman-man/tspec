require 'tspec/version'
require 'tspec/type_error'
require 'tspec/core'

module TSpec
  @method_return_type_table = {}
  @method_arguments_type_table = {}
  @before_trace = {}
  @module_function_flags = {}
  @module_function_mode = {}
  @type_error_flag = false
  HOOK_EVENT = %i(call return c_call c_return)
  DEFINE_METHOD_SYMBOLS = %i(method_added singleton_method_added define_method instance_method method)

  @trace = TracePoint.new(*HOOK_EVENT) do |tp|
    @trace.disable do
      case tp.event
      when :call
        if %i(return receive).include?(tp.method_id) && DEFINE_METHOD_SYMBOLS.include?(@before_trace[:method_id])
          ctx = tp.binding
          keys = get_keys(tp, @before_trace)
          regist_type(tp.method_id, ctx, keys)
        else
          check_type(tp)
        end
      when :c_call
        if tp.method_id == :module_function && tp.defined_class == Module
          @module_function_mode[tp.self] = true

          line = File.readlines(tp.path)[tp.lineno - 1]
          names = line.scan(/:.+/)

          if names.empty?
            @module_function_flags[tp.self] = true
          else
            names.each do |name|
              key = "#{tp.self}:#{name}"

              if type = @method_return_type_table[key]
                @method_return_type_table["#{tp.self.singleton_class}:#{name}"] = type
              end
              if type = @method_arguments_type_table[key]
                @method_arguments_type_table["#{tp.self.singleton_class}:#{name}"] = type
              end
            end
          end
        end
      when :c_return
        if tp.method_id == :module_function && tp.defined_class == Module
          @module_function_mode[tp.self] = false
        end
      when :return
        if !@type_error_flag
          key = "#{tp.defined_class}::#{tp.method_id}"

          if types = @method_return_type_table[key]
            unless value_type_check(tp.return_value, *types)
              @type_error_flag = true
              raise ReturnValueTypeError, "`#{tp.method_id}' expected return #{types.map(&:inspect).join(' or ')}, but actual `#{tp.return_value.inspect}' - #{tp.return_value.class}"
            end
          end
        end
      end

      @type_error_flag = false

      if tp.defined_class != Symbol || !%i(return receive).include?(tp.method_id)
        @before_trace = { self: tp.self, method_id: tp.method_id }
      end
    end
  end

  @trace.enable
end
