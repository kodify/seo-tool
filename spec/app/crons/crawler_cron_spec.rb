require 'spec_helper'

describe CrawlerCron do
  let!(:limit) { 5 }

  before do
    FactoryGirl.create_list :site, 2
    Url.delete_all
    subject.stub(:output_to_console)
  end
  describe 'cron runs with 10 urls in db and limit 5' do
    before do
      FactoryGirl.create_list :url, limit*2
    end
    describe 'output is done' do
      after do
        subject.treat_urls(limit)
      end
      it 'should update 5 urls' do
        subject.should_receive(:say_processing_url).exactly(limit).times
      end
    end
    describe 'status is updated' do
      before do
        subject.treat_urls(limit)
      end
      it 'should update the status for all the treated urls' do
        Url.where(visited_at: Date.new(2000, 1, 1)).length.should eq(limit)
      end
    end
  end

  describe 'cron runs with 5 urls in db and limit 10' do
    before do
      FactoryGirl.create_list :url, limit
    end
    describe 'output is done' do
      after do
        subject.treat_urls(limit*2)
      end
      it 'updating 5 urls' do
        subject.should_receive(:say_processing_url).exactly(limit).times
      end
    end
    describe 'status is updated' do
      before do
        subject.treat_urls(limit)
      end
      it 'should update the status for all the treated urls' do
        Url.where(visited_at: Date.new(2000, 1, 1)).length.should eq(0)
      end
    end
  end

  describe 'cron runs without urls in db' do
    after { subject.treat_urls(limit*2) }
    it 'should not crash' do
      subject.should_receive(:output_to_console).never
    end
  end

  describe 'cron runs with wrong urls in db' do
    before do
      FactoryGirl.create :url, url: 'this_is_not_a_url'
    end
    after do
      subject.treat_urls(limit*2)
    end

    it 'should leave a message and continue' do
      subject.should_receive(:say_unable_to_treat_url)
    end
  end

end