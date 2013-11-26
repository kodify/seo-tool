class Domains
  def process(amount)
    batch_size = [amount.to_i, Url.count].min
    Url.where(:domain_id => nil).limit(batch_size).each do |url|
      save_url_domain(url)
    end
  end

  def save_url_domain(url)
    return if url.nil?
    original_domain = Url.original_domain(url.url)
    return if original_domain == ''
    say "Fetching domain for #{url.url}"
    existing_domain = Domain.where(:url => original_domain).first
    existing_domain ||= Domain.new :url=> original_domain
    existing_domain.subnet = subnet_for url
    existing_domain.save
    url.domain = existing_domain
    url.save
  end

  def say(message)
    if ENV['RAILS_ENV'] != 'production'
      puts message
    end
  end

  def subnet_for(url)
    return unless url.ip
    ip = url.ip.split('.')[0..2].join('.')
    net = Subnet.where(ip: ip).first
    unless net
      net = Subnet.new
      net.ip = ip
      net.save
    end
    net
  end

end





