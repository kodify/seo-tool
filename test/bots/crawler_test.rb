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

    crawler = SimpleMock.new Crawler.new
    crawler.expect :get_html, content, url

    crawler.process_links url

    crawler.verify

  end

end
