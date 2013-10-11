namespace :crawl do
  desc 'Will scrap urls searching for configured domains links'
  task :url => :environment do
    limit = ENV['CRAWL_LIMIT']
    limit = 50 if ENV['CRAWL_LIMIT'].nil?
    CrawlerCron.new.process(limit)
  end

  desc 'seomoz'
  task :seomoz => :environment do
    Seomoz.new.process
  end
end