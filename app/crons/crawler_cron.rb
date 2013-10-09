class CrawlerCron

  def treat_urls(amount)
    crawl = Crawler.new
    Url.all.each do |url|
      output_to_console "Processing #{url.url}..."
      crawl.process_links url
    end
  end

  def output_to_console string
    puts string
  end

end