namespace :crawl do
  desc 'Will scrap urls searching for configured domains links'
  task :url => :environment do

    crawl = Crawler.new
    Url.all.each do |url|
      puts "Processing #{url.url}..."
      crawl.process_links url
    end

  end
end