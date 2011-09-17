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
    it "should inserts recipe before another recipe class" do
      pending "Why I'm not drink beer right now?"
    end

    
  end

=begin
  it "raise an error on invalid index" do
    assert_raise RuntimeError do
      @cookbook.insert_after("HiyaMiddleware", BazMiddleware)
    end
  end
=end
end