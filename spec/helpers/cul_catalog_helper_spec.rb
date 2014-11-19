require 'spec_helper'

describe CulCatalogHelper do

  describe '#per_page_link' do

    context 'no change to items per page' do
      context 'href' do
        it {expect(per_page_link('link.com', 10, 10)).to match /<a href=\"#\"/}
      end
      context 'data-ga-category' do
        it {expect(per_page_link('link.com', 10, 10)).not_to match /data-ga-category/}
      end
    end
    ['catalog', 'articles'].each do |source|
      context "#{source}" do
        context 'change items per page' do
          before {@active_source = source}
          context 'should return the link with new number of pages ' do
            context 'href' do
              it {expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*href=\"link.com\"/}
            end
            context 'per-page' do
              it {expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*per_page=\"25\"/}
            end
          end
          context 'should have Google Analytics tracking category, action and label' do
            context 'data-ga-category' do
              it {expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-category=\"#{@active_source.capitalize} Results List\"/}
            end
            context 'data-ga-action' do
              it {expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-action=\"Display Options\"/}
            end
            context 'data-ga-label' do
              it {expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-label=\"25 per page\"/}
            end
          end
        end
      end
    end
    context 'no active source' do
      context 'data-ga-category' do
        it {expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-category=\"Results List\"/}
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
