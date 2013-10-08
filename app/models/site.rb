class Site < ActiveRecord::Base
  has_many :links

  def to_s
    code
  end
end
