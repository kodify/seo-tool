require 'uri'

class CrawlerCron

  def treat_urls(amount)
    Url.transaction do
      batch_size(amount).times do
        url = Url.order('visited_at ASC').first
        treat_existing_url(url)
      end
    end
  end

  def treat_existing_url(url)
    url.visited_at = Time.now
    url.save
    if url.url =~ URI::regexp
      say_processing_url url.url
      crawl.process_links url
    else
      say_unable_to_treat_url url.url
    end

  end

  def batch_size(amount)
    min = [amount.to_i, Url.count].min
  end

  def say_unable_to_treat_url(url)
    output_to_console "Unable to treat url #{url}"
  end

  def say_processing_url(url)
    output_to_console "Processing #{url}..."
  end

  def crawl
    @crawl ||= Crawler.new
  end

  def output_to_console(string)
    puts string
  end

end