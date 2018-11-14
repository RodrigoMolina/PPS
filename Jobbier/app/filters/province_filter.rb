class ProvinceFilter
  include ActiveModel::Model

  attr_accessor :query, :order, :direction

  def call(country_id=nil)
    ordering = order_field.split(',').map{|x| [x, @direction].compact.join(' ') }.join(', ') if(order_field.present?)
    provinces = (country_id.nil?)? Province.order_default : Province.where(country_id: country_id).order_default
    provinces = provinces.where('provinces.name LIKE :q', q: "%#{@query}%") if @query.present?
    provinces = ordering.present? ? provinces.order(ordering) : provinces.order('provinces.id ASC')
    provinces
  end

  def order_field
    case @order
    when 'id'         then 'provinces.id'
    when 'name'         then 'provinces.name'
    end
  end
end
