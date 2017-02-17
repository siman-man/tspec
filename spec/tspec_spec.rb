describe TSpec do
  describe '.return_type_check' do
    context 'check succeed' do
      it { expect(TSpec.value_type_check(3.14, Float)).to be_truthy }
      it { expect(TSpec.value_type_check('type', String)).to be_truthy }
      it { expect(TSpec.value_type_check(/type/, Regexp)).to be_truthy }
      it { expect(TSpec.value_type_check([1.0, 2.0, 3.0], [Float])).to be_truthy }
      it { expect(TSpec.value_type_check([1.0, '2.0', 3.0], [Float, String])).to be_truthy }
      it { expect(TSpec.value_type_check([[1.0, 2.0, 3.0]], [[Float]])).to be_truthy }
    end

    context 'check failed' do
      it { expect(TSpec.value_type_check(3, Float)).to be_falsey }
      it { expect(TSpec.value_type_check(:type, String)).to be_falsey }
      it { expect(TSpec.value_type_check('type', Regexp)).to be_falsey }
      it { expect(TSpec.value_type_check([1, 2.0, 3.0], [Float])).to be_falsey }
      it { expect(TSpec.value_type_check([1.0, '2.0', 3.0], [String])).to be_falsey }
      it { expect(TSpec.value_type_check([[1, 2.0, 3.0]], [[Float]])).to be_falsey }
    end
  end
end
