require 'net/http'

class MailerManager
  include ActiveModel::Model

  ####################################################
  # EJEMPLO DE USO:                                  #
  #                                                  #
  # manager = MailerManager.new(                     #
  #   sender:     'Sistema MyProductsCatalog',       #
  #   subject:    'Test de envío de mails',          #
  #   recipients: ['hola@jobbier.com'],              #
  #   header:     '¡Hola, Lucas!',                   #
  #   body:       '<p>Cuerpo del mail en HTML.</p>'  #
  # )                                                #
  #                                                  #
  # manager.call                                     #
  ####################################################

  attr_accessor :sender, :sender_email, :subject, :recipients, :header, :body, :reply_to, :attachments, :template_name, :template_params

  def initialize(*args)
    super

    @token = ENV['MESSAGES_API_TOKEN']
    @host  = ENV['MESSAGES_API_URL']
    @port  = ENV['MESSAGES_API_PORT']

    @template_params ||= {}
  end

  def call
    request = Net::HTTP::Post.new("/api/messages")

    request.content_type     = 'application/json'
    request.body             = message.to_json
    request['authorization'] = "Token token=#{@token}"

    Net::HTTP.new(@host, @port).request(request)
  end

  private

  def message
    {
      sender:          sender,
      sender_email:    sender_email,
      subject:         subject,
      recipients:      recipients,
      template_name:   template_name,
      template_params: template_params.merge(body: body, header: header),
      reply_to:        reply_to,
      attachments:     attachments || []
    }
  end
end
