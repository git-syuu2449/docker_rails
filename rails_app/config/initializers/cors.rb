Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '0.0.0.0:5173'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true  # Cookie付き通信（Deviseなど）に必要
  end
end
