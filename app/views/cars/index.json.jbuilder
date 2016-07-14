json.array!(@cars) do |car|
  json.extract! car, :id, :title, :description
  json.url car_url(car, format: :json)
end
