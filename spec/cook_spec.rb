require File.expand_path("spec_helper", File.dirname(__FILE__))

describe Playmo::Cook do
  include Playmo::Cook

  describe 'when created' do
    it 'Object should have cook! method' do
      Object.should respond_to(:cook!)
    end

    it 'should requires cookbook as first argument' do
      lambda { cook!(nil) {} }.should raise_error
    end
  end

  describe '.cook!' do
    xit 'should accept cookbook instance' do

    end

    xit 'should accept cookbook as string' do

    end
    
    xit 'should accept cookbook as symbol' do

    end
  end
end

