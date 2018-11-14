class MyCustomMailer < Devise::Mailer
  helper :application

  def reset_password_instructions(record, token, opts={})
    manager=MailerManager.new(
      sender: 'Soporte jobbier',
      sender_email:'no-reply@jobbier.com',
      subject: 'Restablecer contraseña',
      recipients: [record.email],
      template_name: 'jobbier-reset-password',
      template_params: {
        email: record.email,
        link_reset: edit_user_password_url(record, reset_password_token: token),
        })
    manager.call
  end

  def confirmation_instructions(record, token, opts={})
    manager=MailerManager.new(
      sender: 'Soporte jobbier',
      sender_email:'no-reply@jobbier.com',
      subject: 'Confirmacion de email',
      recipients: [record.email],
      template_name: 'jobbier-confirmnuevo',
      template_params: {
        email: record.email,
        link: user_confirmation_url(record, confirmation_token: token),
        })
    manager.call
  end
end
