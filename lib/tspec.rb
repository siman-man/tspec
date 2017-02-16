module TSpec
  class ReturnValueTypeError < StandardError
  end

  class NotFoundArgumentNameError < StandardError
  end

  class ArgumentTypeError < StandardError
  end
end

class Symbol
  def return(*types)
    self
  end

  def receive(*type, **types)
    self
  end
end

class UnboundMethod
  def return(*types)
    self
  end

  def receive(*type, **types)
    self
  end
end

class Method
  def return(*types)
    self
  end

  def receive(*type, **types)
    self
  end
end

module TSpec
  @method_return_type_table = {}
  @method_arguments_type_table = {}
  @before_trace = {}
  @type_error_flag = false
  DEFINE_METHOD_SYMBOLS = %i(method_added singleton_method_added define_method instance_method method)

  def self.value_type_check(value, *types)
    types.any? do |type|
      if type.instance_of?(Array)
        return false unless value.instance_of?(Array)

        value.all? do |v|
          type.any? do |t|
            value_type_check(v, t)
          end
        end
      else
        value.instance_of?(type)
      end
    end
  end

  TracePoint.trace do |tp|
    case tp.event
      when :call
        if %i(return receive).include?(tp.method_id) && DEFINE_METHOD_SYMBOLS.include?(@before_trace[:method_id])
          ctx = tp.binding

          if %i(instance_method method).include?(@before_trace[:method_id])
            key = "#{tp.self.owner}::#{tp.self.name}"
          else
            klass = (@before_trace[:method_id] == :singleton_method_added) ? @before_trace[:self].singleton_class : @before_trace[:self]
            key = "#{klass}::#{ctx.receiver}"
          end

          case tp.method_id
            when :return
              @method_return_type_table[key] = ctx.local_variable_get(:types)
            when :receive
              @method_arguments_type_table[key] = ctx.local_variable_get(:types)

              if @method_arguments_type_table[key].empty?
                @method_arguments_type_table[key] = {ctx.local_variable_get(:type).__id__ => ctx.local_variable_get(:type)}
              end
          end
        else
          key = "#{tp.defined_class}::#{tp.method_id}"

          if types = @method_arguments_type_table[key]
            arguments = tp.binding.eval("method(:#{tp.method_id}).parameters.map(&:last)")

            types.each do |name, type|
              name = arguments.first if name == type.__id__

              unless arguments.include?(name)
                @type_error_flag = true
                raise NotFoundArgumentNameError, "undefined arguments `#{name}' for #{key}"
              end

              value = tp.binding.local_variable_get(name)

              unless value_type_check(value, *type)
                @type_error_flag = true
                raise ArgumentTypeError, "##{tp.method_id} '#{name}' variable should be #{type.inspect}, but actual '#{value.inspect}' - #{value.class}"
              end
            end
          end
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
      @before_trace = {self: tp.self, method_id: tp.method_id}
    end
  end
end
