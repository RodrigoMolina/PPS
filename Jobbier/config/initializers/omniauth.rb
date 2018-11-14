

SETUP_PROC_FA = lambda do |env|
  env['omniauth.strategy'].options[:client_id] = Const::OAUTH_FACEBOOK_CLIENT
  env['omniauth.strategy'].options[:client_secret] = Const::OAUTH_FACEBOOK_SECRET
end

SETUP_PROC_GO = lambda do |env|
  env['omniauth.strategy'].options[:client_id] = Const::OAUTH_GMAIL_CLIENT
  env['omniauth.strategy'].options[:client_secret] = Const::OAUTH_GMAIL_SECRET
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, setup: SETUP_PROC_FA, scope: 'email,public_profile',
                      info_fields: 'first_name,last_name,email,gender,picture',
                      token_params: {
                        parse: :json
                      }
  provider :google_oauth2, setup: SETUP_PROC_GO, prompt: 'select_account'
end
