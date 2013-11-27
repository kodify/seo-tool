class DomainStatus

  # Processes an amount of domains
  def process(amount = nil)
    batch(amount).each do |domain|
      process_domain domain
    end
  end

  # Get a batch of domains for a given amount, or all of them
  def batch(amount = nil)
    batch_size = [amount.to_i, Domain.count].min
    if amount.nil?
      Domain.where(status_id: nil)
    else
      Domain.where(status_id: nil).limit(batch_size)
    end
  end

  # Processes a domain
  def process_domain(domain)
    if domain.status.nil? && domain.affiliate?
      domain.status = Status.where(name: 'affiliate').first
      domain.save
    end
  end

end