module Integration
  class Type
    def receive_float_return_string(val)
      val.to_s
    end.receive(val: Float).return(String)

    def return_string_receive_symbol(val)
      val.to_s
    end.return(String).receive(val: Symbol)
  end
end
