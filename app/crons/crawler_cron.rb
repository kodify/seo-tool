class CrawlerCron

  def treat_urls(amount)
    crawl = Crawler.new
    Url.transaction do
      Url.order('visited_at DESC').limit(amount).lock(true).each do |url|
        output_to_console "Processing #{url.url}..."
        crawl.process_links url
      end
    end
  end

  def output_to_console string
    puts string
  end

end