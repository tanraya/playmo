# encoding: utf-8

<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_filter :find_<%= class_name.underscore %>, :except => [:index, :new, :create]
  respond_to :html

  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    respond_with(@<%= plural_table_name %>)
  end

  def show
    respond_with(@<%= singular_table_name %>)
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    respond_with(@<%= singular_table_name %>)
  end

  def edit
    respond_with(@<%= singular_table_name %>)
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>

    if @<%= orm_instance.save %>
      flash[:notice] = "<%= human_name %> was successfully created."
    else
      flash[:alert] = "<%= human_name %> has errors."
    end

    respond_with(@<%= singular_table_name %>)
  end

  def update
    if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
      flash[:notice] = "<%= human_name %> was successfully updated."
    else
      flash[:alert] = "<%= human_name %> has errors."
    end

    respond_with(@<%= singular_table_name %>)
  end

  def destroy
    @<%= orm_instance.destroy %>
    respond_with(@<%= singular_table_name %>)
  end

protected

  def find_<%= class_name.underscore %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

end
<% end -%>
