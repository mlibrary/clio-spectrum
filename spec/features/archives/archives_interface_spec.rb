require 'spec_helper'

describe 'Archives Search' do

  before do
    visit archives_index_path('q' => 'papers')
  end

  context 'will be able to traverse next and previous links', js: true do
    context 'first  page', js:true do
      it{expect(page).not_to have_css('.index_toolbar a', text: 'Previous')}
      it{expect(page).to have_css('.index_toolbar a', text: 'Next')}
    end

    context 'next page', js:true do
      before{all('.index_toolbar a', text: 'Next').first.click}

      it{expect(page).to have_css('.index_toolbar a', text: 'Previous')}
      it{expect(page).to have_css('.index_toolbar a', text: 'Next')}
    end

    context 'back to first page', js: true do
      before do
        all('.index_toolbar a', text: 'Next').first.click
        all('.index_toolbar a', text: 'Previous').first.click
      end
      it{expect(page).not_to have_css('.index_toolbar a', text: 'Previous')}
      it{expect(page).to have_css('.index_toolbar a', text: 'Next')}
    end

  end

  let(:search_info){find('#search_info')}
  context 'can move between item-detail and search-results', js: true do
    before do
      visit archives_index_path('q' => 'files')

      within all('.result.document').first do
        find('a').click
      end
    end

    context 'first item detail page', js: true do
      it{expect(search_info).to have_text '1 of '}
      it{expect(page).not_to have_css('#search_info a', text: 'Previous')}
      it{expect(page).to have_css('#search_info a', text: 'Next')}
    end

    context 'next item detail page', js: true do
      before{find('#search_info a', text: 'Next').click}
      it{expect(search_info).to have_text '2 of '}
      it{expect(page).to have_css('#search_info a', text: 'Previous')}
      it{expect(page).to have_css('#search_info a', text: 'Next')}
    end

    context 'previous item detail page', js: true do
      before do
        find('#search_info a', text: 'Next').click
        find('#search_info a', text: 'Previous').click
      end
      it{expect(search_info).to have_text '1 of '}
      it{expect(page).not_to have_css('#search_info a', text: 'Previous')}
      it{expect(page).to have_css('#search_info a', text: 'Next')}
    end

    context 'back to results', js: true do
      before do
        find('#search_info a', text: 'Next').click
        find('#search_info a', text: 'Previous').click
        find('#search_info a', text: 'Back to Results').click
      end
      it{find('.constraints-container').should have_text 'You searched for: files'}
    end
  end

end
