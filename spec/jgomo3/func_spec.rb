RSpec.describe Jgomo3::Func do
  it "has a version number" do
    expect(Jgomo3::Func::VERSION).not_to be nil
  end

  context '`constantly`' do
    it 'provides a Proc that not matter what arguments it receives, it always returns the given `object`' do
      constantly_true = true.constantly
      constantly_10 = 10.constantly
      expect(constantly_true.call(Object.new)).to be_truthy
      expect(constantly_10.call(Object.new)).to be == 10
    end
  end
  
  context '`complement`' do
    it 'provides the complement function of a caller callable' do
      gt_10 = ->(x) { x > 10 }
      lte_10 = gt_10.complement
      expect(lte_10.call(1)).to be_truthy
      expect(lte_10.call(100)).to be_falsey
    end

    it 'provides the comlement function of the method named as the given symbol' do
      negative = :positive?.complement
      expect(negative.call(-1)).to be_truthy
      expect(negative.call(1)).to be_falsey
    end

    it 'raises an ArgumentError when the object is not "Callable"' do
      o = Object.new
      o.instance_eval('undef :to_proc') rescue # Try to remove to_proc if exists
      expect { o.complement }.to raise_error(ArgumentError, /complement/)
    end
  end
  
  context '`then_if`' do
    it 'applies block to object if condition is true' do
      object_1 = Object.new
      object_2 = Object.new
      combination = object_1.then_if(true.constantly) { [object_1, object_2] }
      expect(combination).to eq([object_1, object_2])
    end

    it 'ignores the given block if condition doesn\'t hold true' do
      object_1 = Object.new
      object_2 = Object.new
      combination = object_1.then_if(false.constantly) { [object_1, object_2] }
      expect(combination).to eq(object_1)
    end
  end

  context '`then_unless`' do
    it 'applies block to object if condition is false' do
      object_1 = Object.new
      object_2 = Object.new
      combination = object_1.then_unless(false.constantly) { [object_1, object_2] }
      expect(combination).to eq([object_1, object_2])
    end

    it 'ignores the given block if condition holds true' do
      object_1 = Object.new
      object_2 = Object.new
      combination = object_1.then_unless(true.constantly) { [object_1, object_2] }
      expect(combination).to eq(object_1)
    end
  end
end
