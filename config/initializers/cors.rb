Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "https://admin.home-ify.co.ke"

    # http://localhost:3000

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization'], 
      max_age: 600
  end
end
