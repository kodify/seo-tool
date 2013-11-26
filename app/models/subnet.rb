class Subnet < ActiveRecord::Base
  default_scope { order(links_count: :desc) }
  has_many :domains

  def to_s
    "#{ip}.xxx"
  end

  def links_count
    count = 0
    self.domains.each do |domain|
      count = count + domain.links_counter
    end
    count
  end

  def urls_count
    count = 0
    self.domains.each do |domain|
      count = count + domain.urls.count
    end
    count
  end
end
