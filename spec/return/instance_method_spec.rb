require 'fixtures/return/user'
require 'fixtures/return/instance_methods'

describe TSpec do
  describe 'return test of instance methods' do
    let(:type) { Return::Type.new }
    let(:fuga) { Return::Fuga.new }
    let(:one_two) { Return::One::Two.new }
    let(:child) { Return::Child.new }
    let(:b) { Return::B.new }

    describe 'default' do
      context 'single type' do
        it { expect { type.return_float('no fixnum') }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_float([]) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_float(1_000_000) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_float(1.0) }.not_to raise_error }

        it { expect { type.return_proc(-> x { x ** 2 }) }.not_to raise_error }
        it { expect { type.return_user('sample') }.not_to raise_error }
        it { expect { type.return_float('string') }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_float(33.33) }.not_to raise_error }

        it { expect { type.return_string_array('array') }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_array([1, 2, 3]) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_array(['1', '2', 3]) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_array([]) }.not_to raise_error }
        it { expect { type.return_string_array(%w(1 2 3)) }.not_to raise_error }

        it { expect { type.return_string_double_array('double array') }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_double_array(%w(1 2 3)) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_double_array([%w(1 2 3)]) }.not_to raise_error }
      end

      context 'multiple type' do
        it { expect { type.return_string_or_float([]) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_or_float(:hoge) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_or_float('string') }.not_to raise_error }
        it { expect { type.return_string_or_float(3.14) }.not_to raise_error }

        it { expect { type.return_string_float_array([1, 2, 3]) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_float_array([1.0, 2, 3]) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_float_array([1.0, '2', 3]) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_float_array([1.0, '2', 3.0]) }.not_to raise_error }
      end

      context 'alias method' do
        it { expect { type.return_rxp('rxp') }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_rxp(/rxp/) }.not_to raise_error }
      end

      context 'nested class' do
        it { expect { one_two.return_symbol('hoge') }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { one_two.return_symbol(:hoge) }.not_to raise_error }
      end

      context 'inherited class' do
        it { expect { child.return_float(3) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { child.return_float(3.14) }.not_to raise_error }
      end

      context 'class eval' do
        it { expect { type.return_regexp_class_eval('eval') }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_regexp_class_eval(/eval/) }.not_to raise_error }
      end

      context 'define method' do
        it { expect { type.return_name(123) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_name('tspec') }.not_to raise_error }
      end

      context 'unbound method' do
        it { expect { type.return_string_unbound(123) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_unbound('123') }.not_to raise_error }

        it { expect { type.return_string_or_float_unbound(123) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_or_float_unbound('123') }.not_to raise_error }
        it { expect { type.return_string_or_float_unbound(12.3) }.not_to raise_error }
      end

      context 'method' do
        it { expect { type.return_string_method(3.14) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_method('3.14') }.not_to raise_error }

        it { expect { type.return_string_or_float_method(314) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { type.return_string_or_float_method(3.14) }.not_to raise_error }
        it { expect { type.return_string_or_float_method('314') }.not_to raise_error }
      end
    end

    context 'include module' do
      context 'single type' do
        it { expect { b.return_hash([]) }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { b.return_hash({}) }.not_to raise_error }
        it { expect { b.current_time('2017-02-15') }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { b.current_time(Time.now) }.not_to raise_error }
      end
    end

    context 'prepend module' do
      context 'single type' do
        it { expect { b.message('hello') }.to raise_error(TSpec::ReturnValueTypeError) }
        it { expect { b.message(:hello) }.not_to raise_error }
      end
    end

    context 'private method' do
      it { expect { type.private_test }.to raise_error(TSpec::ReturnValueTypeError) }
    end
  end
end
