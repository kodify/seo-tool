require 'test_helper'
require 'minitest/mock'

class CrawlerTest < ActionView::TestCase

  def links
    links = SimpleMock.new
    links.expect :update_all, true, [{:status => "link not found"}]
    links
  end

  def content
    ''
  end

  def test_basic_behaviour

    url = SimpleMock.new
    url.expect :links, links
    url.expect :url, 'http://www.example.com'

    real_crawler = Crawler.new
    crawler = SimpleMock.new real_crawler
    crawler.expect :sites, [Site.new], nil
    crawler.expect :get_html, content, url



    crawler.process_links url

    crawler.verify

  end

end