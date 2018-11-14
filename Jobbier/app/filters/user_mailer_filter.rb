class UserMailerFilter
  include ActiveModel::Model

  attr_accessor :query, :order, :direction

  def call
    ordering = order_field.split(',').map{|x| [x, @direction].compact.join(' ') }.join(', ') if(order_field.present?)
    user_mailers = UserMailer.all
    user_mailers = user_mailers.where('user_mailers.id = :i', i: @query) if @query.present?
    user_mailers = ordering.present? ? user_mailers.order(ordering) : user_mailers.order('user_mailers.id desc')
    user_mailers
  end

  def order_field
    case @order
    when 'id'         then 'user_mailers.id'
    end
  end
end



