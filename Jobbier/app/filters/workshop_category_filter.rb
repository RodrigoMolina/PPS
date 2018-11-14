class WorkshopCategoryFilter
  include ActiveModel::Model

  attr_accessor :query, :order, :direction

  def call
    ordering = order_field.split(',').map{|x| [x, @direction].compact.join(' ') }.join(', ') if(order_field.present?)
    workshop_categories = WorkshopCategory.all
    workshop_categories = workshop_categories.where('workshop_categories.id = :i', i: @query) if @query.present?
    workshop_categories = workshop_categories.where('workshop_categories.name LIKE :q', q: "%#{@query}%") if @query.present?
    workshop_categories = ordering.present? ? workshop_categories.order(ordering) : workshop_categories.order('workshop_categories.name ASC')
    workshop_categories
  end

  def order_field
    case @order
    when 'id'         then 'workshop_categories.id'
    when 'name'         then 'workshop_categories.name'
    end
  end
end



