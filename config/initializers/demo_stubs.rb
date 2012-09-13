if ENV['DEMO']
  require 'webmock'
  include WebMock::API

  stub_request(:delete, "http://localhost:4000/clients/").
    to_return(status: 200, body: {}.to_json, headers: {'Content-Type' => 'application/json'})
  stub_request(:post, "http://localhost:4000/clients").
    with(body: {name: /.*/}).
    to_return(status: 200, headers: {'Content-Type' => 'application/json'}, body: {name: "some_client", admin: false, private_key: "----this is a private key-----"}.to_json)

  stub_request(:get, "http://localhost:4000/cookbooks?num_versions=1").
    to_return(status:200, body: {'apache2' => '1.1.12', 'mysql' => '5', 'demo entry' => '1.0'}.to_json, headers: {'Content-Type' => 'application/json'})
end

