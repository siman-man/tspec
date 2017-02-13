require 'fixtures/receive/class_methods'

describe TSpec do
  describe 'receive test of class method' do

    context 'single receive' do
      it { expect { Receive::Hoge.receive_string(1234) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::Hoge.receive_string('123') }.not_to raise_error }
    end

    context 'inherited class' do
      it { expect { Receive::Child.receive_string(123) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::Child.receive_string('123') }.not_to raise_error }
    end
  end
end
