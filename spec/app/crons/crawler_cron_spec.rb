require 'spec_helper'

describe CrawlerCron do

  describe 'cron runs with 10 urls in db and limit 5' do
    before do
      FactoryGirl.create_list :url, 10
    end
    after do
      subject.treat_urls(5)
    end
    it 'should update 5 urls' do
      subject.should_receive(:output_to_console).exactly(5).times
    end
    it 'should update the status for all the treated urls' do
      Url.find(:all, :conditions => {last_access: Date.new(2000, 1, 1)}).size.should eq(5)
    end
  end
  describe 'cron runs with 5 urls in db and limit 10' do
    before do
      FactoryGirl.create_list :url, 5
    end
    after do
      subject.treat_urls(10)
    end
    it 'should update 5 urls' do
      subject.should_receive(:output_to_console).exactly(5).times
    end
    it 'should update the status for all the treated urls' do
      Url.find(:all, :conditions => {last_access: Date.new(2000, 1, 1)}).size.should eq(0)
    end

  end

  describe 'cron runs without urls in db' do
    it 'should not crash' do
    end
  end

  describe 'cron runs with wrong urls in db' do
    it 'should leave a message and continue' do
      subject.should_receive(:output_to_console).with('unable to treat url xxx')
    end
  end

end