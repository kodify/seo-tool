class Domain < ActiveRecord::Base
  has_many :urls

  default_scope order('links_counter DESC')
  paginates_per 50

  def to_s
    url
  end

  def status_to_urls(status_id)
    query = "UPDATE `urls` set status_id=? where domain_id=?"
    st = connection.raw_connection.prepare(query)
    st.execute(status_id, object_id)
    st.close
  end
end
