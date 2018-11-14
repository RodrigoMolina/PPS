class CountryFilter
  include ActiveModel::Model

  attr_accessor :query, :order, :direction

  def call
    ordering = order_field.split(',').map{|x| [x, @direction].compact.join(' ') }.join(', ') if(order_field.present?)
    countries = Country.order_default
    countries = countries.where('countries.name LIKE :q', q: "%#{@query}%") if @query.present?
    countries = ordering.present? ? countries.order(ordering) : countries.order('countries.id ASC')
    countries
  end

  def order_field
    case @order
    when 'id'         then 'countries.id'
    when 'name'         then 'countries.name'
    end
  end
end
