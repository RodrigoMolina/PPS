class MessageNormalForm
  include ActiveModel::Model


  attr_accessor :name, :email, :content

  validates :name, :email, :content, presence: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/


  def save
    if valid?
      #Message.create(content: content, remitent: name, email: email)
      true
    else
      false
    end
  end


  def result_msg
    if valid?
      'Mensaje enviado'
    else
      case true
        when errors[:email].first.present?
          errors[:email].first
        else
          'Error al enviar el mensaje'
      end
    end
  end

end

