json.array!(@airvms) do |airvm|
  json.extract! airvm, :id, :encrypted_user, :encrypted_password, :host
  json.url airvm_url(airvm, format: :json)
end
