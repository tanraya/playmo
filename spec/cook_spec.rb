require File.expand_path("spec_helper", File.dirname(__FILE__))

describe Playmo::Cook do
  describe 'when created' do
    it 'should requires cookbook as first argument' do
      lambda { cook!(nil) {} }.should raise_error
    end
  end

  describe '.cook!' do
    xit 'should accept cookbook instance' do

    end
    
    xit 'should accept cookbook as symbol' do

    end
  end
end

