require 'fixtures/integration/instance_methods'

describe TSpec do
  describe 'default' do
    let(:type) { Integration::Type.new }

    context 'single type' do
      it { expect { type.receive_float_return_string(123) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { type.receive_float_return_string(12.3) }.not_to raise_error }
    end
  end
end
