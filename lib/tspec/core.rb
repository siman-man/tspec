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
  module_function

  def value_type_check(value, *types)
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

  def regist_type(method_id, ctx, keys)
    types = ctx.local_variable_get(:types)

    case method_id
      when :return
        regist_return_type(keys, types)
      when :receive
        regist_receive_type(keys, types, ctx.local_variable_get(:type))
    end
  end

  def get_keys(tp, btp)
    ctx = tp.binding
    keys = []

    if %i(instance_method method).include?(btp[:method_id])
      keys << "#{tp.self.owner}::#{tp.self.name}"
    else
      if btp[:method_id] == :singleton_method_added
        klass = btp[:self].singleton_class

        if @module_function_flags[btp[:self]]
          keys << "#{btp[:self]}::#{ctx.receiver}"
        end
      else
        klass = btp[:self]
      end

      keys << "#{klass}::#{ctx.receiver}"
    end

    keys
  end

  def regist_return_type(keys, types)
    keys.each do |key|
      @method_return_type_table[key] = types
    end
  end

  def regist_receive_type(keys, types, type)
    keys.each do |key|
      @method_arguments_type_table[key] = types

      if @method_arguments_type_table[key].empty?
        @method_arguments_type_table[key] = { type.__id__ => type }
      end
    end
  end

  def check_type(tp)
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
          if type.instance_of?(Array)
            raise ArgumentTypeError, "##{tp.method_id} '#{name}' variable should be #{type.map(&:inspect).join(' or ')}, but actual '#{value.inspect}' - #{value.class}"
          else
            raise ArgumentTypeError, "##{tp.method_id} '#{name}' variable should be #{type.inspect}, but actual '#{value.inspect}' - #{value.class}"
          end
        end
      end
    end
  end
end
