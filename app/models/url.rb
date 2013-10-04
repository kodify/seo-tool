class Url < ActiveRecord::Base
  belongs_to :status
  has_many :links
  paginates_per 2

end
