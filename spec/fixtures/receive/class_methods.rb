module Receive
  class Hoge
    def self.receive_string(val)
    end.receive(val: String)

    def self.receive_string_or_array(val)
    end.receive(val: [String, Array])
  end

  class Parent
    def self.receive_string(val)
    end.receive(val: String)
  end

  class Child < Parent
  end
end
