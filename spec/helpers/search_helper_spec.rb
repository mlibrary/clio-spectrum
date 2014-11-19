require 'spec_helper'

describe SearchHelper do

  describe '#display_start_over_link' do
    let(:link){display_start_over_link('catalog')}
    context 'Google Analytics tracking' do
      before :each do
        allow(self).to receive(:datasource_landing_page_path).and_return('/catalog')
      end
      it{expect(link).to match(/data\-ga\-category\=\"Catalog Results List\"/)}
      it{expect(link).to match(/data\-ga\-action=\"Search Bar Click\"/)}
      it{expect(link).to match(/data\-ga\-label=\"Start Over\"/)}
    end

  end


end
