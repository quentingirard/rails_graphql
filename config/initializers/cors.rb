Rails.application.config.action_controller.forgery_protection_origin_check = false # for cookies

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:3000"

    resource "*",
      headers: :any,
      expose: ['access-token', 'expiry', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
