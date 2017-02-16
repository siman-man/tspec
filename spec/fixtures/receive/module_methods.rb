module Receive
  module ModuleFunctionTypeA
    def self.receive_string(val)
    end.receive(val: String)
  end

  module ModuleFunctionTypeB
    def receive_symbol(val)
    end.receive(Symbol)

    module_function :receive_symbol
  end
end