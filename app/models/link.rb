class Link < ActiveRecord::Base
  belongs_to :url
  belongs_to :site

  before_save :increase_domain_counter
  after_destroy :decrease_domain_counter


  def increase_domain_counter
    domain.links_counter = domain.links_counter.to_i + 1
    domain.save
  end

  def decrease_domain_counter
    domain.links_counter = domain.links_counter.to_i - 1
    domain.save
  end

  def domain
    self.url.domain
  end
end
