module Receive
  module ExtendModule
    def receive_string_ext(val)
    end.receive(val: String)
  end

  class ClassMethod
    extend ExtendModule

    def self.receive_string(val)
    end.receive(val: String)

    def self.receive_string_skip_keyword(val)
    end.receive(String)

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
