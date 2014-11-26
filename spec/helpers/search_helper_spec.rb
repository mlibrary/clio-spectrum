require 'spec_helper'

describe SearchHelper do

  describe '#display_start_over_link' do
    let(:link){display_start_over_link('catalog')}
    context 'Google Analytics tracking' do
      before{allow(self).to receive(:datasource_landing_page_path).and_return('/catalog')}
      it{expect(link).to match(/data\-ga\-category\=\"Catalog Results List\"/)}
      it{expect(link).to match(/data\-ga\-action=\"Search Bar Click\"/)}
      it{expect(link).to match(/data\-ga\-label=\"Start Over\"/)}
    end
  end

  describe '#display_basic_search_form' do
    let(:result){display_basic_search_form('catalog')}
    context 'Google Analytics tracking' do
      before{allow(self).to receive(:ga_category_for_results_list).and_return('Catalog Results List')}
      before{allow(self).to receive(:datasource_landing_page_path).and_return('/catalog')}
      before{allow(self).to receive(:determine_search_params).and_return(q: 'stuff')}
      before{allow(self).to receive(:standard_hidden_keys_for_search).and_return({})}
      before{allow(self).to receive(:has_advanced_params?).and_return(false)}
      before{allow(self).to receive(:h)}
      before{@active_source = 'catalog'}
      it{expect(result).to match(/data\-ga\-category\=\"Catalog Results List\"/)}
      it{expect(result).to match(/data\-ga\-action=\"Search Toggle Click\"/)}
      it{expect(result).to match(/data\-ga\-label=\"Switch to Advanced\"/)}
    end
  end

end
