json.array!(@currencies) do |currency|
  json.extract! currency, :id, :curs, :datecurs
  json.url currency_url(currency, format: :json)
end
