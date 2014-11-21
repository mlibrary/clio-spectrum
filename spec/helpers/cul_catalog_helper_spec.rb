require 'spec_helper'

describe CulCatalogHelper do

  ['catalog', 'articles', 'academic_commons', 'journals', 'databases', 'library_web', 'archives', 'new_arrivals', 'newspapers'].each do |source|
    context "#{source}" do
      before {@active_source = source}
      context '#per_page_link' do
        context 'no change to items per page' do
          context 'href' do
            it{expect(per_page_link('link.com', 10, 10)).to match /<a href=\"#\"/}
          end
          context 'data-ga-category' do
            it{expect(per_page_link('link.com', 10, 10)).not_to match /data-ga-category/}
          end
        end

        context 'change items per page' do
          context 'should return the link with new number of pages ' do
            context 'href' do
              it{expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*href=\"link.com\"/}
            end
            context 'per-page' do
              it{expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*per_page=\"25\"/}
            end
          end
          context 'should have Google Analytics tracking category, action and label' do
            context 'data-ga-category' do
              it{expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-category=\"#{@active_source.camelize} Results List\"/}
            end
            context 'data-ga-action' do
              it{expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-action=\"Display Options\"/}
            end
            context 'data-ga-label' do
              it{expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-label=\"25 per page\"/}
            end
          end
        end
      end
      context '#viewstyle_link' do
        before{allow(self).to receive(:get_browser_option).and_return('compact')}
        context 'no change to viewstyle' do
          context 'href' do
            it{expect(viewstyle_link('compact', 'Compact View')).to match /<a [^>]*href=\"#\"/}
          end
          context 'data-ga-category' do
            it{expect(viewstyle_link('compact', 'Compact View')).not_to match /data-ga-category/}
          end
        end
        context 'change from compact to standard view' do
          context 'href' do
            it{expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*href=\"#\"/}
          end
          context 'data-ga-category' do
            it{expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*data-ga-category=\"#{@active_source.camelize} Results List\"/}
          end
          context 'data-ga-action' do
            it{expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*data-ga-action=\"Display Options\"/}
          end
          context 'data-ga-label' do
            it{expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*data-ga-label=\"Standard View\"/}
          end
        end
      end
    end
  end
  context 'no active source' do
    context '#per_page_link' do
      context 'change items per page' do
        context 'data-ga-category' do
          it{expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-category=\"Results List\"/}
        end
        context 'data-ga-action' do
          it{expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-action=\"Display Options\"/}
        end
        context 'data-ga-label' do
          it{expect(per_page_link('link.com', 25, 10)).to match /<a [^>]*data-ga-label=\"25 per page\"/}
        end
      end
    end
    context '#viewstyle_link' do
      context 'change from compact to standard view' do
        before{allow(self).to receive(:get_browser_option).and_return('compact')}
        context 'data-ga-category' do
          it{expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*data-ga-category=\"Results List\"/}
        end
        context 'data-ga-action' do
          it{expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*data-ga-action=\"Display Options\"/}
        end
        context 'data-ga-label' do
          it{expect(viewstyle_link('list', 'Standard View')).to match /<a [^>]*data-ga-label=\"Standard View\"/}
        end
      end
    end
  end
end
