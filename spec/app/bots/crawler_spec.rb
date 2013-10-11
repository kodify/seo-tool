require 'spec_helper'

describe Crawler do
  describe '#process_links' do

    let!(:links)        { double('links', update_all: true) }
    let!(:fake_domain)  { 'http://www.domain.com/blabla' }
    let!(:page)         { double('page', css: [ link ]) }
    let!(:site)         { double('site', domain: 'domain.com', campaign_id: nil )}
    let!(:children)     { 'anchor' }
    let!(:link)         { double('link', attribute: fake_domain, children: children, empty?: false) }
    let!(:sites)        { [site] }
    let!(:url) do
      double('url', links: links, url: 'http://www.google.com', "internal_links=" => nil, 'external_links=' => nil,
             'save' => true, 'visited_at=' => nil, 'ip=' => nil, 'domain=' => nil, 'subdomain=' => nil,
             visited_at: nil, 'domain_authority=' => nil, 'page_authority=' => nil)
    end
    let!(:db_link) do
      double('Link', 'site=' => '', 'url=' => '', 'link=' => '', 'anchor=' => '', 'status=' => '',
             'campaign=' => '', 'affiliate=' => '', 'save' => '')
    end
    let!(:stat) do
      double('stat', 'site=' => '', 'url=' => '', 'internal_links=' => '', 'external_links=' => '', 'save' => '')
    end

    before :each do
      subject.stub(:sites).and_return(sites)
      subject.stub(:get_html).and_return(page)
      subject.stub(:existing_link).and_return(nil)
      subject.stub(:new_link).and_return(db_link)
      subject.stub(:new_stat).and_return(stat)

      subject.process_links(url)
    end

    describe 'given a valid url' do
      it 'should open the remote url' do
        subject.should have_received(:get_html).with(url)
      end
      it 'should look for all anchors in the page' do
        page.should have_received(:css).twice.with('a')
      end
      it 'should update all the links status to not found' do
        links.should have_received(:update_all).with(status: 'link not found')
      end
      it 'should save all found links' do
        db_link.should have_received(:save)
      end
      it 'should save metrics on url' do
        url.should have_received(:save)
      end
      it 'should save statistics on url' do
        stat.should have_received(:save)
      end
    end

  end
end