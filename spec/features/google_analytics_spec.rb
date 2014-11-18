require 'spec_helper'

describe 'Google Analytics' do
  context 'catalog search results page' do
    context 'Selected Items dropdown' do
      before :each do
        visit catalog_index_path('q' => "penguins")
      end
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
      before :each do
        visit catalog_index_path('q' => "penguins", :rows => '50', :per_page => '50')
      end
      context '50 per page' do
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
        end
      end
      context 'in Standard View' do
        before :each do
          visit catalog_index_path('q' => "penguins", :rows => '50', :per_page => '50')
        end
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
  end

  context 'item detail page links' do
    context 'Subjects' do
      before :each do
        visit catalog_path "9092438"
      end
      let(:link){page.all(:xpath, "//a[contains(@href, 'subject')]").first}
      context 'each' do
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
    end
    context "Subjects (Genre)" do
      before :each do
        visit catalog_path "5090546"
      end
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
      before :each do
        visit catalog_path "5090546"
      end
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
      before :each do
        visit catalog_path "5090546"
      end
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
      before :each do
        visit catalog_path "5090546"
      end
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
