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

    it 'should adds declared recipes to its stack' do
      c = cookbook(@name) do
        recipe :one, :two, :three
        recipe :four
      end

      c.recipes.should eq [:one, :two, :three, :four]
    end

    it 'should convert cookbook name to symbol' do
      c = cookbook(@name) do
        recipe 'one', :two
      end

      c.recipes.should eq ['one', :two]
    end
  end
end

