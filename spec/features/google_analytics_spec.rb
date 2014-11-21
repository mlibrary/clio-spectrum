require 'spec_helper'

describe 'Google Analytics' do
  context 'AcademicCommons results page' do
    before {visit academic_commons_index_path('q' => "penguins")}
    xit 'download should not open a new window' do

    end
  end

  context 'AcademicCommons results page' do
    before {visit academic_commons_index_path('q' => "penguins")}
    xit 'download should not open a new window' do

    end
  end

  context 'catalog search results page' do
    context 'Selected Items dropdown' do
      before {visit catalog_index_path('q' => "penguins")}
      context 'Send to Email' do
        let(:link){find("a[id='emailLink']", :visible => false)}
        context 'data-ga-category' do
          it{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          it{expect(link['data-ga-action']).to eq('Selected Items')}
        end
        context 'data-ga-label' do
          it{expect(link['data-ga-label']).to eq('Send to Email')}
        end
      end
      context 'Export to EndNote' do
        let(:link){find("a[id='endnoteLink']", :visible => false)}
        context 'data-ga-category' do
          it{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          it{expect(link['data-ga-action']).to eq('Selected Items')}
        end
        context 'data-ga-label' do
          it{expect(link['data-ga-label']).to eq('Export to EndNote')}
        end
      end
      context 'Add to My Saved List' do
        let(:link){find("a[class='saved_list_add']", :visible => false)}
        context 'data-ga-category' do
          it{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          it{expect(link['data-ga-action']).to eq('Selected Items')}
        end
        context 'data-ga-label' do
          it{expect(link['data-ga-label']).to eq('Add to My Saved List')}
        end
      end
      context 'Select All' do
        let(:link){find("a[onclick=\"selectAll(); return false;\"]", :visible => false)}
        context 'data-ga-category' do
          it{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          it{expect(link['data-ga-action']).to eq('Selected Items')}
        end
        context 'data-ga-label' do
          it{expect(link['data-ga-label']).to eq('Select All Items')}
        end
      end
      context 'Clear All' do
        let(:link){find("a[onclick=\"deselectAll(); return false;\"]", :visible => false)}
        context 'data-ga-category' do
          it{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          it{expect(link['data-ga-action']).to eq('Selected Items')}
        end
        context 'data-ga-label' do
          it{expect(link['data-ga-label']).to eq('Clear All Items')}
        end
      end
    end

    context 'Display Options dropdown' do
      before {visit catalog_index_path('q' => "penguins", :rows => '50', :per_page => '50')}
      context 'currently set to 50 items per page' do
        context 'link to change from 50 to 25 items per page' do
          let(:link){find("a[class=\"per_page_link\"][per_page=\"25\"]")}
          context 'data-ga-category' do
            it{expect(link['data-ga-category']).to eq('Catalog Results List')}
          end
          context 'data-ga-action' do
            it{expect(link['data-ga-action']).to eq('Display Options')}
          end
          context 'data-ga-label' do
            it{expect(link['data-ga-label']).to eq('25 per page')}
          end
        end
        context 'link to change from 50 to 100 items per page' do
          let(:link){find("a[class=\"per_page_link\"][per_page=\"100\"]")}
          context 'data-ga-category' do
            it{expect(link['data-ga-category']).to eq('Catalog Results List')}
          end
          context 'data-ga-action' do
            it{expect(link['data-ga-action']).to eq('Display Options')}
          end
          context 'data-ga-label' do
            it{expect(link['data-ga-label']).to eq('100 per page')}
          end
          context 'no link to 50 per page' do
            it{page.should_not have_link("a[class=\"per_page_link\"][per_page=\"100\"]")}
          end
        end
      end

      context 'in Standard View' do
        before {visit catalog_index_path('q' => "penguins", :rows => '50', :per_page => '50')}
        context 'link to change to Compact View' do
          let(:link){find("a[class=\"viewstyle_link\"][viewstyle=\"compact\"]")}
          context 'data-ga-category' do
            it{expect(link['data-ga-category']).to eq('Catalog Results List')}
          end
          context 'data-ga-action' do
            it{expect(link['data-ga-action']).to eq('Display Options')}
          end
          context 'data-ga-label' do
            it{expect(link['data-ga-label']).to eq('Compact View')}
          end
        end
        context 'no link to Standard View' do
          it{page.should_not have_link("a[class=\"viewstyle_link\"][viewstyle=\"list\"]")}
        end
      end
    end

    context 'Start Over button' do
      before{visit catalog_index_path('q' => "penguins")}
      let(:link){find("a[href=\"\/catalog\"]", :text => 'Start Over')}
      context 'data-ga-category' do
        it{expect(link['data-ga-category']).to eq('Catalog Results List')}
      end
      context 'data-ga-action' do
        it{expect(link['data-ga-action']).to eq('Search Bar Click')}
      end
      context 'data-ga-label' do
        it{expect(link['data-ga-label']).to eq('Start Over')}
      end
    end
  end

  context 'item detail page' do
    context 'toolbar' do
      ['Print', 'Email', 'Send to Phone', 'Add to My Saved List', 'Export to EndNote', 'Display in CLIO Legacy',
       'MARC View', "Place a Recall / Hold", 'Borrow Direct', 'ILL', "Scan & Deliver", 'Inter-Campus Delivery',
       "In-Process / On Order", 'Precataloging', 'Off-site request', 'Item Not On Shelf?'].each do |option_link|
        context "#{option_link}" do
          before {visit catalog_path "9092438"}
          let(:link){within('#outer-container'){find('a[href]', :text => option_link)}}
          context 'data-ga-category' do
            it{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
          end
          context 'data-ga-action' do
            it{expect(link['data-ga-action']).to eq('Toolbar Click')}
          end
          context 'data-ga-label' do
            it{expect(link['data-ga-label']).to eq(option_link)}
          end
        end
      end
    end

    context 'item detail' do
      context 'Subjects' do
        before {visit catalog_path "9092438"}
        let(:link){page.all(:xpath, "//a[contains(@href, 'subject')]").first}
        context 'data-ga-category' do
          it{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
        end
        context 'data-ga-action' do
          it{expect(link['data-ga-action']).to eq('Subjects Click')}
        end
        context 'data-ga-label' do
          it{expect(link['data-ga-label']).to eq(link.text)}
        end
      end

      context "Subjects (Genre)" do
        before{visit catalog_path "5090546"}
        let(:link){find("a", :text=> "International Symposium on Coeliac Disease (10th : 2002 : Paris, France)")}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Subjects (Genre) Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end

      context 'Author' do
        before {visit catalog_path "5090546"}
        let(:link){find("a", :text=> "International Symposium on Coeliac Disease (10th : 2002 : Paris, France)")}
        context 'data-ga-category' do
          it{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
        end
        context 'data-ga-action' do
          it{expect(link['data-ga-action']).to eq('Author Click')}
        end
        context 'data-ga-label' do
          it{expect(link['data-ga-label']).to eq(link.text)}
        end
      end

      context 'Also Listed Under' do
        before {visit catalog_path "5090546"}
        let(:link){find("a", :text=> "International Symposium on Coeliac Disease (10th : 2002 : Paris, France)")}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Also Listed Under Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end

      context 'Medical Subjects' do
        before {visit catalog_path "5090546"}
        let(:link){find("a", :text=> "International Symposium on Coeliac Disease (10th : 2002 : Paris, France)")}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Medical Subjects Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end
    end
  end
end
