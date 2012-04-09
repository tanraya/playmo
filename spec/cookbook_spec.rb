require File.expand_path("spec_helper", File.dirname(__FILE__))

describe Playmo::Cookbook do
  include Playmo::Cookbook

  before do
    @name = :any_cookbook_name
  end

  describe 'when created' do
    it 'Object should have cookbook method' do
      Object.should respond_to(:cookbook)
    end

    it 'should requires name as first argument' do
      lambda { cookbook(nil) {} }.should raise_error
    end

    it 'should convert cookbook name to symbol' do
      c = recipe('any cookbook name') {}
      c.name.should eq :'any cookbook name'
    end

    it 'should requires block as second argument' do
      lambda { cookbook(@name) }.should raise_error
    end

    it 'should optionally requires cookbook description' do
      c = cookbook(@name) { description 'Cookbook description' }
      c.description.should == 'Cookbook description'
    end
  end

  describe 'cookbook configuration' do
    it 'should have recipe method' do
      c = cookbook(@name) {}
      c.should respond_to(:recipe)
    end

    xit 'should adds declared recipes to its stack' do
      c = cookbook(@name) do
        recipe :one, :two, :three
        recipe :four
      end
      
      # TODO Keep instances os recipes in stack instead of symbols
      c.recipes.should eq [:one, :two, :three, :four]
    end

    xit 'should convert recipes names in stack to symbols' do
      c = cookbook(@name) do
        recipe 'one', :two
      end

      c.recipes.should eq ['one', :two]
    end
  end

  describe '.recipe' do
    xit 'should accept one recipe instance with block' do
      c = cookbook(@name) do
        recipe Playmo::Recipe::Recipe.new 'Some recipe' do

        end
      end

      c.recipes.first.name.should eq 'Some recipe'
    end

    xit 'should accept one recipe instance without block' do
      
    end

    xit 'should accept several recipe instances without block' do
      
    end

    xit 'should not accept several recipe instances with block' do
      
    end
  end
end

