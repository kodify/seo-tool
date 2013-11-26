class Domain < ActiveRecord::Base
  belongs_to :status
  has_many :urls

  default_scope { order(links_counter: :desc) }
  paginates_per 50

  def to_s
    url
  end
end
