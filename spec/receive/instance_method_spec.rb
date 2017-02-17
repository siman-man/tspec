require 'fixtures/receive/instance_methods'

describe TSpec do
  describe 'receive test of instance methods' do
    let(:type) { Receive::Type.new }
    let(:child) { Receive::Child.new }

    describe 'normal variable' do
      context 'single receive' do
        it { expect { type.receive_string(1234) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_string('1234') }.not_to raise_error }

        it { expect { type.receive_string_array([1, 2, 3]) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_string_array(%w(a b c)) }.not_to raise_error }
      end

      context 'default value' do
        it { expect { type.receive_string_default(123) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_string_default }.not_to raise_error }
      end

      context 'single parameter' do
        it { expect { type.single_parameter_float(nil) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.single_parameter_float(314) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.single_parameter_float(3.14) }.not_to raise_error }
      end

      context 'single multi parameter' do
        it { expect { type.single_multi_parameter_float_or_string(nil) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.single_multi_parameter_float_or_string(314) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.single_multi_parameter_float_or_string(3.14) }.not_to raise_error }
        it { expect { type.single_multi_parameter_float_or_string('string') }.not_to raise_error }
      end

      context 'multiple arguments' do
        it { expect { type.receive_string_and_float(:str, 123) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_string_and_float('str', 123) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_string_and_float(:str, 3.14) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_string_and_float('str', 3.14) }.not_to raise_error }
      end

      context 'unbound method' do
        it { expect { type.receive_string_unbound(123) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_string_unbound('123') }.not_to raise_error }
      end

      context 'wrong variable name' do
        it { expect { type.wrong_variable_name(1234) }.to raise_error(TSpec::NotFoundArgumentNameError) }
      end

      context 'inherited class' do
        it { expect { child.receive_string(1234) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { child.receive_string('1234') }.not_to raise_error }
      end
    end

    describe 'keyword variable' do
      context 'single keyword' do
        it { expect { type.receive_string_keyword(str: :sym) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_string_keyword(str: 'str') }.not_to raise_error }
      end

      context 'default value' do
        it { expect { type.receive_string_keyword_default(str: 123) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_string_keyword_default }.not_to raise_error }
      end

      context 'multiple keywords' do
        it { expect { type.receive_double_keyword_string_symbol(str: 123, sym: '123') }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_double_keyword_string_symbol(str: '123', sym: '123') }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_double_keyword_string_symbol(str: 123, sym: :sym) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_double_keyword_string_symbol(str: '123', sym: :sym) }.not_to raise_error }
      end

      context 'unbound method' do
        it { expect { type.receive_string_keyword_unbound(str: 123) }.to raise_error(TSpec::ArgumentTypeError) }
        it { expect { type.receive_string_keyword_unbound(str: '123') }.not_to raise_error }
      end

      context 'error message' do
        it { expect { type.receive_string(:error) }.to raise_error(TSpec::ArgumentTypeError, "#receive_string 'val' variable should be String, but actual ':error' - Symbol") }
        it { expect { type.single_parameter_float('314') }.to raise_error(TSpec::ArgumentTypeError, "#single_parameter_float 'val' variable should be Float, but actual '\"314\"' - String") }
      end
    end

    context 'method override' do
      it { expect { child.receive_string_override(:hoge) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { child.receive_string_override('hoge') }.not_to raise_error }
    end

    context 'define method' do
      # FIXME: This test crash ruby.
      xit { expect { type.receive_name(123) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { type.receive_name('tspec') }.not_to raise_error }
    end

    context 'multiple type' do
      it { expect { type.receive_string_or_array(1234) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { type.receive_string_or_array('1234') }.not_to raise_error }
      it { expect { type.receive_string_or_array([1, 2, 3]) }.not_to raise_error }
    end
  end
end
