class Url < ActiveRecord::Base
  belongs_to :status
  has_many :links
end
