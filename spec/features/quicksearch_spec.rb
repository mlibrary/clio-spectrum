require 'spec_helper'

describe 'QuickSearch landing page' do

# No, it shouldn't.  The home page should show ONLY the QuickSearch search box.
  # it "should display search fields for archives, catalog, new arrivals, journals" do
  #   visit root_path
  #   page.should have_css(".search_box.catalog option")
  #   page.should have_css(".search_box.new_arrivals option")
  #   page.should have_css(".search_box.academic_commons option")
  #   page.should have_css(".search_box.journals option")
  # end

  # NEXT-612 - Quick search page doesn't let you start over
  context "'Start Over' link" do
    before :each do
      visit quicksearch_index_path('q' => 'borneo')
      expect(page).not_to have_content('Loading...')
    end
    it "should be there", js: true do
      expect(find('.landing_across')).to have_css('a', :text => 'Start Over')
    end
    it "should take us to the landing page", js: true do
      within('.landing_across') do
        click_link('Start Over')
      end
      expect(page).not_to have_css('.result_set')
      expect(page).to have_text('Quicksearch performs a combined search of')
    end
  end
  it "has search results", js: true  do
    visit quicksearch_index_path('q' => 'borneo')
    expect(page).not_to have_content('Loading...')
    expect(page).to have_css('.result_set > .nested_result_set', count: 4)
    expect(page).to have_css('.result_set > .nested_result_set > .result', count: 19)
  end
  # NEXT-1026 - Clicking 'All Results' for Libraries Website 
  # from Quicksearch shows an XML file
  # NEXT-1027 - Relabel 'All #### results' on Quicksearch
  # *** CATALOG ***
  it "should link to Catalog results correctly", js:true do
    visit quicksearch_index_path('q' => 'kitty')
    expect(page).not_to have_content('Loading...')
    # page.save_and_open_page
    within('.results_header', :text => "Catalog") do
      click_link "View and filter all"
    end
    expect(page).to have_text "You searched for: kitty"
  end
  # *** ARTICLES ***
  it "should link to Articles results correctly", js:true do
    visit quicksearch_index_path('q' => 'indefinite')
    expect(page).not_to have_content('Loading...')
    within('.results_header', :text => "Articles") do
      click_link "View and filter all"
    end
    expect(page).to have_text "You searched for: indefinite"
  end
  # *** ACADEMIC COMMONS ***
  it "should link to Academic Commons results correctly", js:true do
    visit quicksearch_index_path('q' => 'uncommon')
    expect(page).not_to have_content('Loading...')
    # page.save_and_open_page
    expect(page).to have_css('.results_header[data-source="academic_commons"]')
    expect(page).not_to have_content('Loading...')
    within('.results_header', :text => "Academic Commons") do
      find('a', :text => "View and filter all").trigger('click')
    end
    expect(page).to have_text "You searched for: uncommon"
  end
  # *** CATALOG ***
  it "should link to Libraries Website results correctly", js:true do
    visit quicksearch_index_path('q' => 'public')
    expect(page).not_to have_content('Loading...')
    # page.save_and_open_page
    expect(find('.results_header', :text => "Libraries Website")).not_to have_text "View and filter all"
    page.find_link("View all").trigger('click')
    expect(page).to have_text "You searched for: public"
  end


  # NEXT-849 - Quicksearch & Other Data Sources: "i" Information Content
  # NEXT-1048 - nothing happend when you click on the little round "i"
  it "should show popover i-button text in aggregates", js: true do
    # QUICKSEARCH
    visit quicksearch_index_path('q' => 'horse')
    expect(page).not_to have_content('Loading...')
    within('.results_header[data-source=catalog]') do
      find('img').trigger('click')
      expect(find('.category_title')).to have_text 'Library books, journals, music, videos, databases, archival collections, and online resources'
    end
    within('.results_header[data-source=articles]') do
      find('img').trigger('click')
      expect(find('.category_title')).to have_text "Articles, e-books, dissertations, music, images, and more from a mostly full-text database"
    end
    within('.results_header[data-source=academic_commons]') do
      find('img').trigger('click')
      expect(find('.category_title')).to have_text "Publications and other research output from Columbia University's digital repository"
    end
    within('.results_header[data-source=library_web]') do
      find('img').trigger('click')
      expect(find('.category_title')).to have_text 'Information about the libraries from the Libraries Website'
    end

    # DISSERTATIONS
    visit dissertations_index_path('q' => 'horse')
    expect(page).not_to have_content('Loading...')
    within('.results_header[data-source=catalog_dissertations]') do
      find('img').trigger('click')
      expect(find('.category_title')).to have_text "Dissertations from the library catalog"
    end
    within('.results_header[data-source=dissertations]') do
      find('img').trigger('click')
      expect(find('.category_title')).to have_text "Dissertations and theses from the Articles database. Many are full-text."
    end
    within('.results_header[data-source=ac_dissertations]') do
      find('img').trigger('click')
      expect(find('.category_title')).to have_text "Dissertations deposited in Columbia's digital repository, primarily 2011-present."
    end

    # EBOOKS
    visit ebooks_index_path('q' => 'horse')
    expect(page).not_to have_content('Loading...')
    within('.results_header[data-source=catalog_ebooks]') do
      find('img').trigger('click')
      expect(find('.category_title')).to have_text "E-books from the library catalog"
    end
    within('.results_header[data-source=ebooks]') do
      find('img').trigger('click')
      expect(find('.category_title')).to have_text "E-books from the Articles database"
    end
  end
end
