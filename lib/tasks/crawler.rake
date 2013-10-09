namespace :crawl do
  desc 'Will scrap urls searching for configured domains links'
  task :url => :environment do
    limit = ENV['CRAWL_LIMIT']
    limit = 50 if ENV['CRAWL_LIMIT'].nil?
    cron = CrawlerCron.new
    cron.treat_urls(limit)
  end
end