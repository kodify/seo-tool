json.array!(@sites) do |site|
  json.extract! site, :code, :domain, :campaignId
  json.url site_url(site, format: :json)
end
