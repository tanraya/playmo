require File.expand_path("spec_helper", File.dirname(__FILE__))

describe Playmo::Recipe do
  include Playmo::Recipe

  before do
    @name = :any_recipe_name
  end

  describe 'when created' do
    it 'Object should have recipe method' do
      Object.should respond_to(:recipe)
    end

    it 'should requires name as first argument' do
      lambda { recipe(nil) {} }.should raise_error
    end
=begin
    it 'should convert recipe name to symbol' do
      c = recipe('any recipe name') {}
      c.name.should eq :'any recipe name'
    end
=end
    it 'should optionally requires block as second argument' do
      lambda { recipe(@name) }.should_not raise_error
    end

    it 'should optionally requires recipe description' do
      r = recipe(@name) { description 'Recipe description' }
      r.description.should == 'Recipe description'
    end

    it 'should optionally requires recipe version' do
      r = recipe(@name) { version '0.0.1' }
      r.version.should == '0.0.1'
    end
  end

  
end

