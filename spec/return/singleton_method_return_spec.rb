describe TSpec do

  describe 'singleton methods' do
    let(:str_singleton) do
      str = 'hello'

      def str.return_string(val)
        val
      end.return(String)

      def str.return_string_or_symbol(val)
        val
      end.return(String, Symbol)

      str
    end

    context 'single type' do
      it { expect { str_singleton.return_string(3) }.to raise_error(TSpec::ReturnValueTypeError) }
      it { expect { str_singleton.return_string('3') }.not_to raise_error }
    end

    context 'multiple type' do
      it { expect { str_singleton.return_string_or_symbol(3) }.to raise_error(TSpec::ReturnValueTypeError) }
      it { expect { str_singleton.return_string_or_symbol('three') }.not_to raise_error }
      it { expect { str_singleton.return_string_or_symbol(:three) }.not_to raise_error }
    end
  end
end
