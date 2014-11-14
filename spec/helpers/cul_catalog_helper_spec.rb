require 'spec_helper'

describe CulCatalogHelper do

  describe '#per_page_link' do
    context 'no change to items per page' do
      it 'should return a link to #' do
        expect(per_page_link('link.com', 10, 10)).to match /<a href=\"#\"/
      end
      it 'should have no Google Analytics tracking' do
        expect(per_page_link('link.com', 10, 10)).not_to match /data-ga-category/
      end
    end
    context 'change items per page' do
      it 'should return the link with new number of pages ' do
        expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*href=\"link.com\"/
        expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*per_page=\"25\"/
      end
      it 'should have Google Analytics tracking category, action and label' do
        expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-category=\"Catalog Results List\"/
        expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-action=\"Display Options\"/
        expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-label=\"25 per page\"/
      end
    end
  end

  describe '#viewstyle_link' do
    context 'no change to viewstyle' do
      it 'should return a link to #' do
        allow(self).to receive(:get_browser_option).and_return('compact')
        expect(viewstyle_link('compact', 'Compact View')).to match /<a [^>]*href=\"#\"/
      end
      it 'should have no Google Analytics tracking' do
        allow(self).to receive(:get_browser_option).and_return('compact')
        expect(viewstyle_link('compact', 'Compact View')).not_to match /data-ga-category/
      end
    end
    context 'change from compact to standard view' do
      it 'should return a link to #' do
        allow(self).to receive(:get_browser_option).and_return('compact')
        expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*href=\"#\"/
      end
      it 'should have Google Analytics tracking category, action and label' do
        allow(self).to receive(:get_browser_option).and_return('compact')
        expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*data-ga-category=\"Catalog Results List\"/
        expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*data-ga-action=\"Display Options\"/
        expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*data-ga-label=\"Standard View\"/
      end
    end
  end
end
