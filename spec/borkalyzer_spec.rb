describe Borkalyzer do

  let(:subject) { described_class }

  shared_examples 'borker' do |string,expected|
    it "transforms #{string} into #{expected}" do
      expect(subject.bork("#{string} #{string}")).to eq("#{expected} #{expected}")
    end
  end

  it_behaves_like 'borker', 'bork',       'bork'
  it_behaves_like 'borker', 'Bork',       'Bork'
  it_behaves_like 'borker', 'the',        'zee'
  it_behaves_like 'borker', 'The',        'Zee'
  it_behaves_like 'borker', 'hhh',        'hhh'
  it_behaves_like 'borker', 'Hhh',        'Hhh'
  it_behaves_like 'borker', 'ahhahha',    'ehhehha'
  it_behaves_like 'borker', 'anhhanhhan', 'unhhunhhun'
  it_behaves_like 'borker', 'ehhehhe',    'ihhehhe-a'
  it_behaves_like 'borker', 'enhhenhhen', 'eehhenhhen'
  it_behaves_like 'borker', 'ewhhewhhew', 'ivhhoohhoo'
  it_behaves_like 'borker', 'fhhfhhf',    'fhhffhhff'
  it_behaves_like 'borker', 'ohhohho',    'oohhuhhu'
  it_behaves_like 'borker', 'owhhowhhow', 'oovhhoohhoo'
  it_behaves_like 'borker', 'uhhuhhu',    'uhhoohhoo'
  it_behaves_like 'borker', 'vhhvhhv',    'fhhfhhf'
  it_behaves_like 'borker', 'whhwhhw',    'vhhvhhv'
  it_behaves_like 'borker', 'whhwhhw',    'vhhvhhv'
  it_behaves_like 'borker', '',           ''


  it 'adds Bork Bork Bork! after newlines' do
    expect( subject.bork "\n" ).to eq "\nBork Bork Bork!\n"
  end


  it "doesn't add methods to String by default" do
    expect(String.new).not_to respond_to(:bork)
  end

  context 'messing with classes' do
    before :all do
      described_class.monkey_patch(String)
    end
    it 'adds #bork to Strings' do
      expect(String.new).to respond_to(:bork)
    end
  end

end
