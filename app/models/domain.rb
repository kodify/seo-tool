class Domain < ActiveRecord::Base
  belongs_to :status
  belongs_to :subnet
  has_many :urls

  default_scope { order(links_counter: :desc) }
  paginates_per 50

  def to_s
    url
  end

  def affiliate?
    if status.nil?
      if affiliates_count > 5
        true
      else
        false
      end
    elsif status.affiliate?
      true
    else
      false
    end
  end

  def affiliates_count
    Url.joins(:links).where('links.affiliate' => 'yes', domain: self).count
  end

end
