require 'openssl'
require 'base64'
require 'cgi'
require 'json'
require 'net/http'
require 'uri'

module SeomozHelper

  def seomoz_batch(batched_domains)
    JSON.parse seomoz_domain_metrics(batched_domains)
  end

  def seomoz_domain_metrics(batched_domains)
    encoded_domains = batched_domains.to_json
    uri             = URI.parse("#{seomoz_request_url}")
    http            = Net::HTTP.new(uri.host, uri.port)
    request         = Net::HTTP::Post.new(uri.request_uri)
    request.body    = encoded_domains
    http.request(request).body
  end

  def seomoz_request_url
    expires	            = Time.now.to_i + 300
    string_to_sign      = "#{seomoz_access_id}\n#{expires}"
    binary_signature    = OpenSSL::HMAC.digest('sha1', seomoz_secret_key, string_to_sign)
    url_safe_signature  = CGI::escape(Base64.encode64(binary_signature).chomp)
    cols                = '103079215108'
    "http://lsapi.seomoz.com/linkscape/url-metrics/?Cols=#{cols}&AccessID=#{seomoz_access_id}&Expires=#{expires}&Signature=#{url_safe_signature}"
  end

  def seomoz_configured?
    seomoz_access_id && seomoz_secret_key
  end

  def seomoz_access_id
    ENV['SEOMOZ_ACCESS_ID']
  end
  def seomoz_secret_key
    ENV['SEOMOZ_SECRET_KEY']
  end


end