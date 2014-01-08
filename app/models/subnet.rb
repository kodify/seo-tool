class Subnet < ActiveRecord::Base
  default_scope { order(domains_count: :desc) }
  has_many :domains

  def to_s
    "#{ip}.xxx"
  end

  def urls_count
    self.domains.sum { |domain|  domain.urls.count }
  end

  def domains_count
    self.domains.count
  end
end
