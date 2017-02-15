module Return
  class Type
    def return_string(val)
      val
    end.return(String)

    def return_float(val)
      val
    end.return(Float)

    def return_proc(val)
      val
    end.return(Proc)

    def return_user(val)
      User.new(val)
    end.return(User)

    def return_string_or_float(val)
      val
    end.return(String, Float)

    def return_string_array(val)
      val
    end.return([String])

    def return_string_float_array(val)
      val
    end.return([String, Float])

    def return_string_double_array(val)
      val
    end.return([[String]])

    def return_regexp(val)
      val
    end.return(Regexp)

    alias_method :return_rxp, :return_regexp

    def private_test
      return_array
    end

    define_method(:return_name) { |name| name }.return(String)

    private
    def return_array
      '1234'
    end.return(Array)
  end

  Type.class_eval {
    def return_regexp_class_eval(val)
      val
    end.return(Regexp)
  }

  class Fuga
    def return_fixnum(val)
      val
    end.return(Fixnum)
  end

  class One
    class Two
      def return_symbol(val)
        val
      end.return(Symbol)
    end
  end

  module A
    def return_hash(val)
      val
    end.return(Hash)

    def current_time(val)
      val
    end.return(String)
  end

  module C
    def message(val)
      val
    end.return(Symbol)

    def current_time(val)
      val
    end.return(Time)
  end

  class B
    include A
    prepend C

    def message(val)
      val
    end.return(String)
  end

  class Parent
    def return_float(val)
      val
    end.return(Float)
  end

  class Child < Parent
  end
end
