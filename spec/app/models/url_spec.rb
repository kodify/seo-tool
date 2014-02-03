require 'spec_helper'

describe Url do
  describe '#original_domain' do
    let!(:high_level_domain) { 'com' }
    let!(:url) { "http://www.supu.#{high_level_domain}" }

    before do
      subject.url = url
    end

    describe 'one word domain' do
      it 'should return one word domain' do
        subject.original_domain.should eq 'supu.com'
      end
    end
    describe 'two words domain' do
      let!(:high_level_domain) { 'com.es' }
      it 'should return two words domain' do
        subject.original_domain.should eq 'supu.com.es'
      end
    end
  end
end