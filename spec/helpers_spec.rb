require File.expand_path("spec_helper", File.dirname(__FILE__))

describe Playmo::Helpers do
  it 'should have recipe, cookbook and cook! methods' do
    %w( recipe cookbook cook! ).each do |method|
      should respond_to(method.to_sym)
    end
  end
end