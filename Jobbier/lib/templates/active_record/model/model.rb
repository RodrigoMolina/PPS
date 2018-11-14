<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  
  include Destroyable

  #--------------------------------------------- RELATION
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %>
<% end -%>

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS
  
end
<% end -%>



