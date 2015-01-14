require 'spec_helper'

describe CulCatalogHelper do

  ['catalog', 'articles', 'academic_commons', 'journals', 'databases', 'library_web', 'archives', 'new_arrivals', 'newspapers'].each do |source|
    context "#{source}" do
      before {@active_source = source}
      describe '#ga_category_for_results_list' do
      end

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
        end
      end
      context '#viewstyle_link' do
        before{allow(self).to receive(:get_browser_option).and_return('compact_list')}
        context 'no change to viewstyle' do
          context 'href' do
            it{expect(viewstyle_link('compact_list', 'Compact View')).to match /<a [^>]*href=\"#\"/}
          end
          context 'data-ga-category' do
            it{expect(viewstyle_link('compact_list', 'Compact View')).not_to match /data-ga-category/}
          end
        end
        context 'change from compact to standard view' do
          context 'href' do
            it{expect(viewstyle_link('standard_list', 'Standard View')).to match /<a [^>]*href=\"#\"/}
          end
        end
      end
    end
  end

  describe '#ga_category_for_results_list' do
  {'catalog' => 'Catalog Results List',
   'articles' => 'Articles Results List',
   'academic_commons' => 'Academic Commons Results List',
   'journals' => 'Journals Results List',
   'databases' => 'Databases Results List',
   'library_web' => 'Library Web Results List',
   'archives' => 'Archives Results List',
   'new_arrivals' => 'New Arrivals Results List'}.each_pair do |k, v|
    context "#{v[k]}" do
      before{@active_source = k}
      it{expect(ga_category_for_results_list).to eq(v)}
      end
    end
  end

  describe '#ga_category_for_item_detail' do
  {'catalog' => 'Catalog Item Detail',
   'articles' => 'Articles Item Detail',
   'academic_commons' => 'Academic Commons Item Detail',
   'journals' => 'Journals Item Detail',
   'databases' => 'Databases Item Detail',
   'library_web' => 'Library Web Item Detail',
   'archives' => 'Archives Item Detail',
   'new_arrivals' => 'New Arrivals Item Detail'}.each_pair do |k, v|
    context "#{v[k]}" do
      before{@active_source = k}
      it{expect(ga_category_for_item_detail).to eq(v)}
      end
    end
  end

end
