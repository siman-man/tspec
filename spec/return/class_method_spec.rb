require 'fixtures/return/class_methods'

describe TSpec do
  describe 'return test of class methods' do
    let(:d) { Return::D.new }

    describe 'default' do
      context 'single type' do
        it { expect { Return::ClassMethod.return_string(3) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { Return::ClassMethod.return_string(1.0) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { Return::ClassMethod.return_string('string') }.not_to raise_error }
      end

      context 'multiple type' do
        it { expect { Return::ClassMethod.return_string_or_array(3) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { Return::ClassMethod.return_string_or_array('string') }.not_to raise_error }
        it { expect { Return::ClassMethod.return_string_or_array([]) }.not_to raise_error }
      end
    end

    describe 'class eval' do
      context 'single type' do
        it { expect { Return::ClassMethod.return_float(1) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { Return::ClassMethod.return_float(1.0) }.not_to raise_error }
      end
    end

    describe 'exclude module' do
      context 'single type' do
        it { expect { d.return_string(123) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { d.return_string('123') }.not_to raise_error }
      end
    end
  end
end
