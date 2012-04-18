require File.expand_path("spec_helper", File.dirname(__FILE__))
require File.expand_path("../lib/playmo/object", File.dirname(__FILE__))

describe Object do
  it 'should automatically extend Object to support recipe, cookbook and cook! methods' do
    %w( recipe cookbook cook! ).each do |method|
      Object.should respond_to(method.to_sym)
    end
  end
end