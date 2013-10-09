class Url < ActiveRecord::Base
  belongs_to :status
  has_many :links
  has_many :stats

  paginates_per 50

end
