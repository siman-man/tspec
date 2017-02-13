describe TSpec do

  describe 'singleton methods' do
    let(:str_singleton) do
      str = 'hello'

      def str.receive_string(val)
        val
      end.receive(val: String)

      str
    end

    context 'single type' do
      it { expect { str_singleton.receive_string(3) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { str_singleton.receive_string('3') }.not_to raise_error }
    end
  end
end
