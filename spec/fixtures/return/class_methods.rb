module Return
  class ClassMethod
    def self.return_string(val)
      val
    end.return(String)

    def self.return_string_or_array(val)
      val
    end.return(String, Array)
  end

  ClassMethod.class_eval {
    def self.return_float(val)
      val
    end.return(Float)
  }

  class Fuga
    def self.return_fixnum(val)
      val
    end.return(Fixnum)
  end

  module C
    def return_string(val)
      val
    end.return(String)
  end

  class D
    extend C
  end
end
