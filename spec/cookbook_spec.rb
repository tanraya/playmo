require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '/../lib/playmo/cookbook.rb')

describe Playmo::Cookbook do
  before(:each) do
    @cookbook = Playmo::Cookbook.new
  end

  context "when instantiated" do
    it "should be with no recipes" do
      @cookbook.size.should be_zero
    end
  end

  context "when insert recipes" do
    context "when insert one recipe" do
      it "should be with one recipe" do
        @cookbook.use(Playmo::Generators::Recipes::HomeControllerRecipe)
        @cookbook.size.should eq(1)
      end
    end
  end
end