module Receive
  class Type
    def receive_string(val)
    end.receive(val: String)

    def receive_string_default(val = 'default')
    end.receive(val: String)

    def receive_string_array(val)
    end.receive([String])

    def wrong_variable_name(val)
    end.receive(vl: Float)

    def single_parameter_float(val)
    end.receive(Float)

    def receive_string_keyword(str:)
    end.receive(str: String)

    def receive_string_keyword_default(str: 'string')
    end.receive(str: String)

    def receive_double_keyword_string_symbol(str:, sym:)
    end.receive(str: String, sym: Symbol)

    def single_multi_parameter_float_or_string(val)
    end.receive(Float, String)

    def receive_string_and_float(str, flt)
    end.receive(str: String, flt: Float)

    def receive_string_or_array(val)
    end.receive(val: [String, Array])

    define_method(:receive_name) { |name| name }.receive(name: String)
  end

  class Parent
    def receive_string(val)
    end.receive(val: String)

    def receive_string_override(val)
    end.receive(val: Symbol)
  end

  class Child < Parent
    def receive_string_override(val)
    end.receive(val: String)
  end
end
