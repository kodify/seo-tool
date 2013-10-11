class Domains
  def process(amount)
    batch_size = [amount.to_i, Url.count].min
    url = Url.where(:domain_id => nil).limit(batch_size).each do |url|
      save_url_domain(url)
    end
  end

  def save_url_domain(url)
    return if url.nil?
    original_domain = Url.original_domain(url.url)
    return if original_domain == ''
    puts "Fetching domain for #{url.url}"
    existing_domain = Domain.where(:url => original_domain).first
    existing_domain ||= Domain.new :url=> original_domain
    existing_domain.save
    url.domain = existing_domain
    url.save
  end

end





