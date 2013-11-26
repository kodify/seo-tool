class Link < ActiveRecord::Base
  belongs_to :url
  belongs_to :site

  def domain
    self.url.domain
  end
end
