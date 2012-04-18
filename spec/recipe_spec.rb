require File.expand_path("spec_helper", File.dirname(__FILE__))

describe Playmo::Recipe do
  before do
    
  end

  describe 'when created' do
    it 'should optionally requires name as first argument' do
      lambda { Playmo::Recipe.new {} }.should_not raise_error
    end

    it 'should requires a block' do
      lambda { Playmo::Recipe.new }.should raise_error
    end

    it 'should optionally requires recipe description' do
      r = Playmo::Recipe.new { description 'Recipe description' }
      r.description.should == 'Recipe description'
    end

    it 'should optionally requires recipe version' do
      r = Playmo::Recipe.new { version '0.0.1' }
      r.version.should == '0.0.1'
    end
  end
end

