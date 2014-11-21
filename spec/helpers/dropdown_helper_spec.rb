require 'spec_helper'

describe DropdownHelper do

  describe '#link_to_item_detail_with_ga' do
    context 'Google Analytics tracking' do
      let(:link){link_to_item_detail_with_ga("MARC View", "catalog/9092438/librarian_view", {:id => 'librarian_link', :name => 'librarian_view'})}
      context 'data-ga-category' do
        it{expect(link).to match /<a [^>]*data-ga-category=\"Catalog Item Detail\"/}
      end
      context 'data-ga-action' do
        it{expect(link).to match /<a [^>]*data-ga-action=\"Toolbar Click\"/}
      end
      context 'data-ga-label' do
        it{expect(link).to match /<a [^>]*data-ga-label=\"MARC View\"/}
      end
      context 'href' do
        it{expect(link).to match /<a [^>]*href=\"catalog\/9092438\/librarian_view\"/}
      end
      context 'id' do
        it{expect(link).to match /<a [^>]*id=\"librarian_link\"/}
      end
      context 'name' do
        it{expect(link).to match /<a [^>]*name=\"librarian_view\"/}
      end
    end
  end
end

def escape_parens(str)
  str.gsub(/[()\[\]]/, '(' => '\(', ')' => '\)', '\[' => '\[', '\]' => '\]')
end
end
