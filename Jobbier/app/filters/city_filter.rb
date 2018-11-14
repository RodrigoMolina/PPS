class CityFilter
  include ActiveModel::Model

  attr_accessor :query, :order, :direction

  def call(province_id=nil)
    ordering = order_field.split(',').map{|x| [x, @direction].compact.join(' ') }.join(', ') if(order_field.present?)
    cities = (province_id.nil?)? City.order_default : City.where(province_id: province_id).order_default
    cities = cities.where('cities.name LIKE :q', q: "%#{@query}%") if @query.present?
    cities = ordering.present? ? cities.order(ordering) : cities.order('cities.id ASC')
    cities
  end

  def order_field
    case @order
    when 'id'         then 'cities.id'
    when 'name'         then 'cities.name'
    end
  end
end



