require File.expand_path("spec_helper", File.dirname(__FILE__))

describe Playmo do
  it 'should automatically extend Object to support recipe, cookbook and cook! methods' do
    %w( recipe cookbook cook! ).each do |method|
      Object.should respond_to(method.to_sym)
    end
  end
end