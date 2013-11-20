class Url < ActiveRecord::Base
  belongs_to :domain
  has_many :links
  has_many :stats

  validates_uniqueness_of :url

  paginates_per 50

  def self.original_subdomain(url_string)
    return '' if invalid_url? url_string

    begin
      url = "http://#{url_string}" if URI.parse(url_string).scheme.nil?
      return URI.parse(url_string).host.downcase
    rescue Exception
      return ''
    end
  end

  def self.original_domain(url_string)
    return '' if invalid_url? url_string

    begin
      url = "http://#{url_string}" if URI.parse(url_string).scheme.nil?
      return Addressable::URI.parse(url_string).downcase
    rescue Exception
      return ''
    end
  end

  def self.invalid_url?(url_string)
    return true if url_string.empty?
    return true if url_string.starts_with?('/') or url_string.starts_with?('#')
    return true unless url_string =~ URI::regexp
    return true if url_string.starts_with?('mailto:')
    return true if url_string.starts_with?('javascript:')
  end

end
