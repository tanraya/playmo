# encoding: utf-8

<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  # Constants
  # Includes
  # Associations
  <%- attributes.select {|attr| attr.reference? }.each do |attribute| -%>
  belongs_to :<%= attribute.name %>
  <% end -%>
  # Delegations
  # Validations
  # Callbacks
  # InstantMethods
  # ClassMethods 
end
<% end -%>
