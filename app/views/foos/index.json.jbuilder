json.array!(@foos) do |foo|
  json.extract! foo, :id, :description, :number
  json.url foo_url(foo, format: :json)
end
