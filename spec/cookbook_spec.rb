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
=begin
    it 'should convert cookbook name to symbol' do
      c = recipe('any cookbook name') {}
      c.name.should eq :'any cookbook name'
    end
=end
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
    it 'should accept one recipe instance with block' do
      c = cookbook(@name) do
        recipe Playmo::Recipe::Recipe.new 'Some recipe' do
          description "Some description"
        end
      end

      c.recipes.first.description.should eq 'Some description'
    end

    it 'should accept one recipe instance without block' do
      r = Playmo::Recipe::Recipe.new('Some recipe') do
        description "Some description"
      end
        
      c = cookbook(@name) do
        recipe(r)
      end

      c.recipes.first.description.should eq 'Some description'
    end

    it 'should accept several recipes instances without block' do
      first = Playmo::Recipe::Recipe.new('First recipe') do
        description "First description"
      end

      second = Playmo::Recipe::Recipe.new('Second recipe') do
        description "Second description"
      end

      c = cookbook(@name) do
        recipe(first, second)
      end

      [c.recipes.first.description, c.recipes.last.description].should eq ['First description', 'Second description']
    end

    it 'should accept string as first argument and block as a second' do
      c = cookbook(@name) do
        recipe 'Some recipe' do
          description "Some description"
        end
      end

      c.recipes.first.description.should eq 'Some description'
    end

    it 'should accept symbol as first argument and block as a second' do
      c = cookbook(@name) do
        recipe :some do
          description "Some description"
        end
      end

      c.recipes.first.description.should eq 'Some description'
    end
  end
end

