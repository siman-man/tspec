require 'fixtures/return/module_methods'

describe TSpec do
  describe 'module method test' do
    context 'single type' do
      it { expect { ModuleFunctionTypeA.return_string(123) }.to raise_error(TSpec::ReturnValueTypeError) }
    end

    # TODO: To pass this test.
    context 'module function type A' do
      xit { expect { ModuleFunctionTypeB.return_symbol('hoge') }.to raise_error(TSpec::ReturnValueTypeError) }
    end
  end
end
