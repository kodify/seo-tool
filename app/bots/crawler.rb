require 'open-uri'

class Crawler

  def process_links(url)
    set_url_links_as_not_found url
    page = get_html url
    debugger

    sites.each do |site|
      page_links_to_site(page, site).each do |link|
        save_link(url, site, link)
      end
    end
  end


  protected


  ##
  #
  #
  def save_link(url, site, link)
    link_path = link.attribute('href').to_s

    db_link = Link.where(link: link_path, url: url, site: site).first || Link.new
    db_link.site       = site
    db_link.url        = url
    db_link.link       = link_path
    db_link.anchor     = link.children.to_s
    db_link.status     = 'link found'
    db_link.campaign   = campaign link_path, site.campaignId
    db_link.affiliate  = affiliate? db_link.campaign

    db_link.save
  end


  ##
  # Get page for a given url
  #
  def get_html(url)
    doc = Nokogiri::HTML(open(url.url))
  end


  ##
  # Get all site related links on a page
  #
  def page_links_to_site(page, site)

    links = []
    page.css('a').each do |link|
      if link.attribute('href').to_s.include? site.domain
        links << link
      end
    end
    links
  end


  ##
  # Get all configured sites
  #
  def sites
    Site.all
  end


  ##
  # Get if url is for an affiliate or not
  #
  def affiliate?(campaign)
    return 'yes' if campaign
    'no'
  end


  ##
  # get the campaign parameter for a given url
  #
  def campaign(link, campaing_id)
    query = Rack::Utils.parse_query URI(link).query
    if query.include? campaing_id
      query[campaing_id]
    end
  end


  ##
  # Updates all url related links to status link not found
  #
  def set_url_links_as_not_found(url)
    url.links.update_all(status: 'link not found')
  end

end