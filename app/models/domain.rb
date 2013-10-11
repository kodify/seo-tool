class Domain < ActiveRecord::Base
  has_many :urls

  paginates_per 50

  def to_s
    url
  end
end
