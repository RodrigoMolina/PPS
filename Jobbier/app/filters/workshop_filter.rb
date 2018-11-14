class WorkshopFilter
  include ActiveModel::Model

  attr_accessor :query, :order, :direction, :category, :city

  def call
    ordering = order_field.split(',').map{|x| [x, @direction].compact.join(' ') }.join(', ') if(order_field.present?)
    workshops = Workshop.joins(:category).joins(:city)
    workshops = workshops.where('categories.name LIKE :c', c: "%#{@category}") if @category.present?
    workshops = workshops.where('cities.name LIKE :j', j: "%#{@city}") if @city.present?
    workshops = workshops.where('workshops.activity_title LIKE :q', q: "%#{@query}%") if @query.present?
    workshops = ordering.present? ? workshops.order(ordering) : workshops.order('workshops.id desc')
    workshops
  end

  def order_field
    case @order
    when 'activity_title'         then 'workshops.activity_title'
    end
  end
end
