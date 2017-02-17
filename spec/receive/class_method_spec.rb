require 'fixtures/receive/class_methods'

describe TSpec do
  describe 'receive test of class method' do

    context 'single receive' do
      it { expect { Receive::ClassMethod.receive_string(1234) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::ClassMethod.receive_string('123') }.not_to raise_error }

      it { expect { Receive::ClassMethod.receive_string_skip_keyword(123) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::ClassMethod.receive_string_skip_keyword('123') }.not_to raise_error }
    end

    context 'multiple receive' do
      it { expect { Receive::ClassMethod.receive_string_or_array(123) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::ClassMethod.receive_string_or_array('hello') }.not_to raise_error }
      it { expect { Receive::ClassMethod.receive_string_or_array([]) }.not_to raise_error }
    end

    context 'inherited class' do
      it { expect { Receive::Child.receive_string(123) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::Child.receive_string('123') }.not_to raise_error }
    end

    context 'extend module' do
      it { expect { Receive::ClassMethod.receive_string_ext(123) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::ClassMethod.receive_string_ext('123') }.not_to raise_error }
    end
  end
end
