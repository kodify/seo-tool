class Subnet < ActiveRecord::Base
  default_scope { order(links_count: :desc) }
  has_many :domains

  def to_s
    "#{ip}.xxx"
  end

  def urls_count
    self.domains.sum { |domain|  domain.urls.count }
  end
end
