require 'spec_helper'

describe CulCatalogHelper do

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
