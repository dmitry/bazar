if Rails.env.production?
  Airbrake.configure do |config|
    config.api_key = Bazar::Application.secrets.errbit_key
    config.host    = Bazar::Application.secrets.errbit_host
    config.port    = 80
    config.secure  = config.port == 443
  end
end