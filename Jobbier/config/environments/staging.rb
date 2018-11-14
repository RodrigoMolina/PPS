require File.expand_path(File.dirname(__FILE__) + '/../environments/production.rb')
Rails.application.configure do
	config.action_mailer.default_url_options = {host: 'jobbier.com:88'}
end
