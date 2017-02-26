module Receive
  module ModuleFunctionTypeA
    def self.receive_string(val)
    end.receive(val: String)

    def self.receive_string_array(val)
    end.receive(val: [[String]])

    def self.receive_string_or_float(val)
    end.receive(val: [String, Float])
  end

  module ModuleFunctionTypeB
    def receive_symbol(val)
    end.receive(Symbol)

    module_function :receive_symbol
  end

  module ModuleFunctionTypeC
    module_function

    def receive_string(val)
    end.receive(String)
  end

  class ModuleFunctionTest
    include ModuleFunctionTypeC

    def test_module_function_type_c(val)
      receive_string(val)
    end
  end
end
