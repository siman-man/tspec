module Return
  module ModuleFunctionTypeA
    def self.return_string(val)
      val
    end.return(String)

    def self.return_string_or_regexp(val)
      val
    end.return(String, Regexp)

    def self.return_string_array(val)
      val
    end.return([String])
  end

  module ModuleFunctionTypeB
    def return_symbol(val)
      val
    end.return(Symbol)

    module_function :return_symbol
  end
end
