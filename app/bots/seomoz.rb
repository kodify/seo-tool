require 'openssl'
require 'base64'
require 'cgi'
require 'json'
require 'net/http'
require 'uri'

class Seomoz
  def process
    return unless configured?
    urls.each do |url|
      puts "Processing #{url.url}"
      authority = batch([url.url]).first
      if authority.include?('pda') && authority.include?('upa')
        url.domain_authority = authority['pda']
        url.page_authority = authority['upa']
        url.save
        puts "\tupdated"
      else
        puts "\tnot updated: #{authority.to_s}"
      end
    end
  end

  protected

  def urls
    Url.where("domain_authority = '' OR domain_authority IS NULL").limit(500)
  end

  def batch(batched_domains)
    JSON.parse domain_metrics(batched_domains)
  end

  def domain_metrics(batched_domains)
    encoded_domains = batched_domains.to_json
    uri             = URI.parse("#{request_url}")
    http            = Net::HTTP.new(uri.host, uri.port)
    request         = Net::HTTP::Post.new(uri.request_uri)
    request.body    = encoded_domains
    http.request(request).body
  end

  def request_url
    expires	            = Time.now.to_i + 300
    string_to_sign      = "#{access_id}\n#{expires}"
    binary_signature    = OpenSSL::HMAC.digest('sha1', secret_key, string_to_sign)
    url_safe_signature  = CGI::escape(Base64.encode64(binary_signature).chomp)
    cols                = '103079215108'
    "http://lsapi.seomoz.com/linkscape/url-metrics/?Cols=#{cols}&AccessID=#{access_id}&Expires=#{expires}&Signature=#{url_safe_signature}"
  end

  def configured?
    access_id && secret_key
  end

  def access_id
    ENV['ACCESS_ID']
  end
  def secret_key
    ENV['SECRET_KEY']
  end

end