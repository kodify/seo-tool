if ['production', 'development'].include? Rails.env
  raise 'Env variable oauth_id not setted' unless ENV['OAUTH_ID']
  raise 'Env variable oauth_secret not setted' unless ENV['OAUTH_SECRET']
  raise 'Env variable valid_domain not setted' unless ENV['OAUTH_VALID_DOMAIN']
end
