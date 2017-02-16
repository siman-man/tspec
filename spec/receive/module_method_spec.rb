require 'fixtures/receive/module_methods'

describe TSpec do
  describe 'module method test' do
    context 'single type' do
      it { expect { Receive::ModuleFunctionTypeA.receive_string(123) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { Receive::ModuleFunctionTypeA.receive_string('123') }.not_to raise_error }
    end

    # TODO: To pass this test.
    context 'module function type A' do
      xit { expect { Receive::ModuleFunctionTypeB.receive_symbol('hoge') }.to raise_error(TSpec::ArgumentTypeError) }
    end
  end
end