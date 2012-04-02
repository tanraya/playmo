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
      r = recipe(@name) { description 'Cookbook description' }
      r.description.should == 'Cookbook description'
    end
  end
end

