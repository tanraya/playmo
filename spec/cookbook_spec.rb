# encoding: utf-8
require File.expand_path("spec_helper", File.dirname(__FILE__))

describe Playmo::Cookbook do
  before do
    @name = :any_cookbook_name
  end

  describe 'when created' do
    it 'should optionally requires name as first argument' do
      lambda { Playmo::Cookbook.new(nil) {} }.should_not raise_error
    end

    it 'should requires a block' do
      lambda { Playmo::Cookbook.new }.should raise_error
    end

    it 'should optionally requires cookbook description' do
      c = Playmo::Cookbook.new { description 'Cookbook description' }
      c.description.should == 'Cookbook description'
    end
  end

  describe 'cookbook configuration' do
    it 'should have recipe method' do
      c = Playmo::Cookbook.new {}
      c.should respond_to(:recipe)
    end

    it 'should add cookbook to stack if name specified' do
      c = Playmo::Cookbook.new(@name) {}
      
      # TODO Keep recipes instances in stack instead of symbols
      Playmo::COOKBOOKS[@name].should eq c
    end
  end

  describe '.recipe' do
    it 'should accept one recipe instance' do
      r = Playmo::Recipe.new   { description "Some description" }
      c = Playmo::Cookbook.new { recipe(r) }
      c.cookbook_recipes.first.description.should eq 'Some description'
    end

    it 'should accept several anonymous recipes instances' do
      first  = Playmo::Recipe.new { description "First description" }
      second = Playmo::Recipe.new { description "Second description" }
      c = Playmo::Cookbook.new { recipe(first, second) }

      [c.cookbook_recipes.first.description, c.cookbook_recipes.last.description].should eq ['First description', 'Second description']
    end

    it 'should accept a block' do
      c = Playmo::Cookbook.new do
        recipe { description "Some description" }
      end

      c.cookbook_recipes.first.description.should eq 'Some description'
    end
  end
end

