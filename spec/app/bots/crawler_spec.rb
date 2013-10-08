require 'spec_helper'

describe Crawler, 'Crawler' do

  let!(:url) { double('url', links: links, url: 'http://www.google.com') }
  let!(:links) { double('links', update_all: true) }

  it 'all links status should be set to not found' do
    links.should_receive(:update_all).with(status: 'link not found')
    subject.stub(:get_html).and_return('html')
    subject.stub(:sites).and_return([])
    subject.process_links(url)
    subject.should have_received(:get_html).with(url)
  end

  it 'should save all the links ' do
    fakeDomain = 'domain/blabla'

    sites = [site]
    subject.stub(:sites).and_return(sites)
    page = double('page')
    subject.stub(:get_html).and_return(page)
    link = linkDef(fakeDomain)
    page.should_receive(:css).with('a').and_return([link])
    #subject.stub(:save_link).with(url, site, link).and_return(true)
    Link = double('linkGeneral')
    Link.should_receive(:where).with({:link => fakeDomain, :url => url, :site => site}).and_return([])
    Link.should_receive(:new).and_return(dbLink)
    subject.process_links(url)
  end

  def site
    if @site.nil?
      @site = double('site')
      @site.should_receive(:domain).and_return('domain')
      @site.should_receive(:campaignId).and_return(nil)
    end
    @site
  end

  def linkDef(fakeDomain)
    link = double('link')
    link.should_receive(:attribute).with('href').and_return(fakeDomain)
    link.should_receive(:attribute).with('href').and_return(fakeDomain)
    link.should_receive(:children).and_return('anchor')
    link
  end

  def dbLink
    dbLink = double(Link)
    dbLink.should_receive(:site=)
    dbLink.should_receive(:url=)
    dbLink.should_receive(:link=)
    dbLink.should_receive(:anchor=)
    dbLink.should_receive(:status=).with('link found')
    dbLink.should_receive(:campaign).and_return(nil)
    dbLink.should_receive(:campaign=).with(nil)
    dbLink.should_receive(:affiliate=)
    dbLink.should_receive(:save).and_return(true)
    dbLink
  end
end