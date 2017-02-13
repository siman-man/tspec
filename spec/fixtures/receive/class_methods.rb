module Receive
  class Hoge
    def self.receive_string(val)
    end.receive(val: String)
  end

  class Parent
    def self.receive_string(val)
    end.receive(val: String)
  end

  class Child < Parent
  end
end
