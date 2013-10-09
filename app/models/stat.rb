class Stat < ActiveRecord::Base
  belongs_to :site
  belongs_to :url
end
