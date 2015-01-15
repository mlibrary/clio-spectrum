require 'spec_helper'

describe 'E-Journals Search' do

  context 'can traverse next and previous links' , js:true do
    before :each do
      visit journals_index_path('q' => 'notes')
    end
    context 'on search-results page' do
      it{expect(page).not_to have_css('.index_toolbar a', text: 'Previous')}
      it{expect(page).to have_css('.index_toolbar a', text: 'Next')}
    end

    context 'next results page', js: true do
      before{all('.index_toolbar a', text: 'Next').first.trigger('click')}
      it{expect(page).to have_css('.index_toolbar a', text: 'Previous')}
      it{expect(page).to have_css('.index_toolbar a', text: 'Next')}
    end

    context 'previous results page', js: true do
      before :each do
        all('.index_toolbar a', text: 'Next').first.trigger('click')
        all('.index_toolbar a', text: 'Previous').first.trigger('click')
      end
      it{expect(page).not_to have_css('.index_toolbar a', text: 'Previous')}
      it{expect(page).to have_css('.index_toolbar a', text: 'Next')}
    end
  end

  context 'can move between item-detail and search-results', js: true do
    before :each do
      visit journals_index_path('q' => 'letters')

      within all('.result.document').first do
        all('a').first.trigger('click')
      end
    end

    # page.save_and_open_page # debug

    context 'first item', js: true do
      it{expect(page).to have_css('#search_info', text: '1 of ')}
      it{expect(page).not_to have_css('#search_info a', text: 'Previous')}
      it{expect(page).to have_css('#search_info a', text: 'Next')}
    end

    it 'next item', js: true do
      expect(page).to have_css('#search_info a', text: 'Next')
      find('#search_info a', text: 'Next').trigger('click')
      expect(page).to have_css('#search_info', text: '2 of ')
      expect(page).to have_css('#search_info', text: '2 of ')
      expect(page).to have_css('#search_info a', text: 'Previous')
      expect(page).to have_css('#search_info a', text: 'Next')
    end

    context 'previous item', :js => true do
      before :each do
        find('#search_info a', text: 'Next').trigger('click')
        expect(page).to have_css('#search_info', text: '2 of ')
        find('#search_info a', text: 'Previous').trigger('click')
        expect(page).to have_css('#search_info', text: '1 of ')
      end
      it{expect(page).to have_css('#search_info', text: '1 of ')}
      it{expect(page).not_to have_css('#search_info a', text: 'Previous')}
      it{expect(page).to have_css('#search_info a', text: 'Next')}
    end

    context 'return to search results', js: true do
      before{find('#search_info a', text: 'Back to Results').trigger('click')}
      it{expect(page).to have_css('.constraints-container', text: 'You searched for: letters')}
    end

  end

end
