class <%= class_name %>Controller < ApplicationController
  respond_to :html, :json

<% for action in actions -%>
  def <%= action %>
    # ...
  end

<% end -%>
end

