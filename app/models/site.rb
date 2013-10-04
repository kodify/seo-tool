class Site < ActiveRecord::Base
  def to_s
    code
  end
end
