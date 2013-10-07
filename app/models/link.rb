class Link < ActiveRecord::Base
  belongs_to :url
  belongs_to :site
end
