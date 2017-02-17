require 'fixtures/receive/module_methods'

describe TSpec do
  describe 'module method test' do
    context 'single type' do
      it { expect { Receive::ModuleFunctionTypeA.receive_string(123) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::ModuleFunctionTypeA.receive_string('123') }.not_to raise_error }
    end

    context 'multiple type' do
      it { expect { Receive::ModuleFunctionTypeA.receive_string_or_float(123) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::ModuleFunctionTypeA.receive_string_or_float('123') }.not_to raise_error }
      it { expect { Receive::ModuleFunctionTypeA.receive_string_or_float(12.3) }.not_to raise_error }
    end

    context 'array content' do
      it { expect { Receive::ModuleFunctionTypeA.receive_string_array([1,2,3]) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::ModuleFunctionTypeA.receive_string_array(%w(1 2 3)) }.not_to raise_error }
      it { expect { Receive::ModuleFunctionTypeA.receive_string_array([]) }.not_to raise_error }
    end

    # TODO: To pass this test.
    context 'module function type B' do
      xit { expect { Receive::ModuleFunctionTypeB.receive_symbol('hoge') }.to raise_error(TSpec::ArgumentTypeError) }
    end
  end
end