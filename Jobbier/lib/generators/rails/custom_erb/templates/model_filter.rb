class <%= class_name %>Filter
  include ActiveModel::Model

  attr_accessor :query, :order, :direction

  def call
    ordering = order_field.split(',').map{|x| [x, @direction].compact.join(' ') }.join(', ') if(order_field.present?)
    <%= plural_table_name %> = <%= class_name %>.all
    <%= plural_table_name %> = <%= plural_table_name %>.where('<%= plural_table_name %>.id = :i', i: @query) if @query.present?
    <%- attributes.reject(&:password_digest?).each do |attribute| -%>
    <%= plural_table_name %> = <%= plural_table_name %>.where('<%= plural_table_name %>.<%= attribute.name %> LIKE :q', q: "%#{@query}%") if @query.present?
    <%- end -%>
    <%= plural_table_name %> = ordering.present? ? <%= plural_table_name %>.order(ordering) : <%= plural_table_name %>.order('<%= plural_table_name %>.id desc')
    <%= plural_table_name %>
  end

  def order_field
    case @order
    when 'id'         then '<%= plural_table_name %>.id'
<% attributes.each do |attribute| -%>
    when '<%= attribute.column_name %>'         then '<%= plural_table_name %>.<%= attribute.column_name %>'
<% end -%>
    end
  end
end



