describe TSpec do

  describe 'singleton methods' do
    let(:str_singleton) do
      str = 'hello'

      def str.receive_string(val)
      end.receive(val: String)

      def str.receive_float_skip_keyword(val)
      end.receive(Float)

      def str.receive_string_or_float(val)
      end.receive(val: [String, Float])

      def str.receive_string_method(val)
      end

      str.method(:receive_string_method).receive(val: String)

      str
    end

    context 'single type' do
      it { expect { str_singleton.receive_string(3) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { str_singleton.receive_string('3') }.not_to raise_error }
    end

    context 'skip keyword' do
      it { expect { str_singleton.receive_float_skip_keyword(314) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { str_singleton.receive_float_skip_keyword(3.14) }.not_to raise_error }
    end

    context 'unbound method' do
      it { expect { str_singleton.receive_string_method(3.14) }.to raise_error(TSpec::ArgumentTypeError) }
      it { expect { str_singleton.receive_string_method('3.14') }.not_to raise_error }
    end
  end
end
