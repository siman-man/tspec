require 'fixtures/return/module_methods'

describe TSpec do
  describe 'module method test' do
    context 'single type' do
      it { expect { Return::ModuleFunctionTypeA.return_string(123) }.to raise_error(TSpec::ReturnValueTypeError) }
      it { expect { Return::ModuleFunctionTypeA.return_string('123') }.not_to raise_error }
    end

    context 'multiple type' do
      it { expect { Return::ModuleFunctionTypeA.return_string_or_regexp(123) }.to raise_error(TSpec::ReturnValueTypeError) }
      it { expect { Return::ModuleFunctionTypeA.return_string_or_regexp('123') }.not_to raise_error }
      it { expect { Return::ModuleFunctionTypeA.return_string_or_regexp(/123/) }.not_to raise_error }
    end

    context 'array content' do
      it { expect { Return::ModuleFunctionTypeA.return_string_array([1,2,3]) }.to raise_error(TSpec::ReturnValueTypeError) }
      it { expect { Return::ModuleFunctionTypeA.return_string_array(%w(1 2 3)) }.not_to raise_error }
      it { expect { Return::ModuleFunctionTypeA.return_string_array([]) }.not_to raise_error }
    end

    # TODO: To pass this test.
    context 'module function type B' do
      xit { expect { Return::ModuleFunctionTypeB.return_symbol('hoge') }.to raise_error(TSpec::ReturnValueTypeError) }
    end
  end
end
