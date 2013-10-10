require 'uri'

class CrawlerCron

  def treat_urls(amount)
    crawl = Crawler.new
    Url.transaction do
      Url.order('visited_at DESC').limit(amount).lock(true).each do |url|
        output_to_console "Processing #{url.url}..."
        if url.url =~ URI::regexp
          crawl.process_links url
        else
          output_to_console "Unable to treat url #{url.url}"
        end

      end
    end
  end

  def output_to_console string
    puts string
  end

end