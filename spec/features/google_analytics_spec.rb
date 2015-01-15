require 'spec_helper'

describe 'Google Analytics' do

  context 'catalog search results page' do
    context 'Selected Items dropdown' do
      before {visit catalog_index_path('q' => "penguins")}
      context 'Send to Email' do
        let(:link){find("a[id='emailLink']", :visible => false)}
        it do
          puts 'lol'
        end
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Selected Items')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq('Send to Email')}
        end
      end

      context 'Export to EndNote' do
        let(:link){find("a[id='endnoteLink']", :visible => false)}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Selected Items')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq('Export to EndNote')}
        end
      end

      context 'Add to My Saved List' do
        let(:link){find("a[class='saved_list_add']", :visible => false)}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Selected Items')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq('Add to My Saved List')}
        end
      end

      context 'Select All' do
        let(:link){find("a[onclick=\"selectAll(); return false;\"]", :visible => false)}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Selected Items')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq('Select All Items')}
        end
      end

      context 'Clear All' do
        let(:link){find("a[onclick=\"deselectAll(); return false;\"]", :visible => false)}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Selected Items')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq('Clear All Items')}
        end
      end
    end

    context 'Display Options dropdown' do
      before {visxit catalog_index_path('q' => "penguins", :rows => '50', :per_page => '50')}
      context 'currently set to 50 xitems per page' do
        context 'link to change from 50 to 25 xitems per page' do
          let(:link){find("a[class=\"per_page_link\"][per_page=\"25\"]")}
          context 'data-ga-category' do
            xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
          end
          context 'data-ga-action' do
            xit{expect(link['data-ga-action']).to eq('Display Options')}
          end
          context 'data-ga-label' do
            xit{expect(link['data-ga-label']).to eq('25 per page')}
          end
        end

        context 'link to change from 50 to 100 xitems per page' do
          let(:link){find("a[class=\"per_page_link\"][per_page=\"100\"]")}
          context 'data-ga-category' do
            xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
          end
          context 'data-ga-action' do
            xit{expect(link['data-ga-action']).to eq('Display Options')}
          end
          context 'data-ga-label' do
            xit{expect(link['data-ga-label']).to eq('100 per page')}
          end
          context 'no link to 50 per page' do
            xit{page.should_not have_link("a[class=\"per_page_link\"][per_page=\"100\"]")}
          end
        end
      end

      context 'in Standard View' do
        before {visxit catalog_index_path('q' => "penguins", :rows => '50', :per_page => '50')}
        context 'link to change to Compact View' do
          let(:link){find("a[class=\"viewstyle_link\"][viewstyle=\"compact_list\"]", visible: false)}
          context 'data-ga-category' do
            xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
          end
          context 'data-ga-action' do
            xit{expect(link['data-ga-action']).to eq('Display Options')}
          end
          context 'data-ga-label' do
            xit{expect(link['data-ga-label']).to eq('Compact View')}
          end
        end
        context 'no link to Standard View' do
          xit{page.should_not have_link("a[class=\"viewstyle_link\"][viewstyle=\"compact_list\"]")}
        end
      end
    end

    context 'Sort by dropdown' do
      before {visxit catalog_index_path('q' => "penguins", :rows => '50', :per_page => '50')}
      ['Relevance', 'Acquired Earliest', 'Acquired Latest', 'Published Earliest', 'Published Latest',
       'Author A-Z', 'Author Z-A', 'Txitle A-Z', 'Txitle Z-A'].each do |option|
        context "#{option}" do
          let(:link){find("a[href!='#']", :text => option)}
          context 'data-ga-category' do
            xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
          end
          context 'data-ga-action' do
            xit{expect(link['data-ga-action']).to eq('Sort by')}
          end
          context 'data-ga-label' do
            xit{expect(link['data-ga-label']).to eq(option)}
          end
        end
      end
    end

    context 'Start Over button' do
      before{visxit catalog_index_path('q' => "penguins")}
      let(:link){find("a[href=\"\/catalog\"]", :text => 'Start Over')}
      context 'data-ga-category' do
        xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
      end
      context 'data-ga-action' do
        xit{expect(link['data-ga-action']).to eq('Search Bar Click')}
      end
      context 'data-ga-label' do
        xit{expect(link['data-ga-label']).to eq('Start Over')}
      end
    end

    context 'advanced search toggle' do
      before{visxit catalog_index_path('q' => "penguins")}
      context 'swxitch to advanced search' do
        let(:link){find("a", :text => 'Advanced Search')}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Search Toggle Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq('Swxitch to Advanced')}
        end
      end
      context 'swxitch to basic search' do
        before{find('.search_box.catalog .advanced_search_toggle').click}
        let(:link){find("a", :text => 'Basic Search')}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Results List')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Search Toggle Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq('Swxitch to Basic')}
        end
      end
    end
  end

  context 'xitem detail page' do
    context 'toolbar' do
      ['Print', 'Email', 'Send to Phone', 'Add to My Saved List', 'Export to EndNote', 'Display in CLIO Legacy',
       'MARC View', "Place a Recall / Hold", 'Borrow Direct', 'ILL', "Scan & Deliver", 'Inter-Campus Delivery',
       "In-Process / On Order", 'Precataloging', 'Off-sxite request', 'Item Not On Shelf?', 'Start Over'].each do |option_link|
        context "#{option_link}" do
          before {visxit catalog_path "9092438"}
          let(:link){wxithin('#outer-container'){find('a[href]', :text => option_link)}}
          context 'data-ga-category' do
            xit{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
          end
          context 'data-ga-action' do
            xit{expect(link['data-ga-action']).to eq('Toolbar Click')}
          end
          context 'data-ga-label' do
            xit{expect(link['data-ga-label']).to eq(option_link)}
          end
        end
      end
    end

    context 'catalog xitem detail' do
      context 'search toggle' do
        ["Advanced", "Basic"].each do |option_link|
          context "Swxitch to #{option_link}" do
            before {visxit catalog_path "9092438"}
            let(:link){wxithin('#outer-container'){find('a[href]', :text => option_link)}}
            context 'data-ga-category' do
              xit{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
            end
            context 'data-ga-action' do
              xit{expect(link['data-ga-action']).to eq('Search Toggle Click')}
            end
            context 'data-ga-label' do
              xit{expect(link['data-ga-label']).to eq("Swxitch to #{option_link}")}
            end
          end
        end
      end

      context 'Subjects' do
        before {visxit catalog_path "9092438"}
        let(:link){page.all(:xpath, "//a[contains(@href, 'subject')]").first}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Subjects Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end

      context "Subjects (Genre)" do
        before{visxit catalog_path "4127482"}
        let(:link){find("a", :text=> "Electronic journals.")}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Subjects Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end

      context 'Author' do
        before {visxit catalog_path "5090546"}
        let(:link){find("a", :text=> "International Symposium on Coeliac Disease (10th : 2002 : Paris, France)")}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Author Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end

      context 'Also Listed Under' do
        before {visxit catalog_path "5090546"}
        let(:link){find("a", :text=> "Cerf-Bensussan, N.")}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Author Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end

      context 'Medical Subjects' do
        before {visxit catalog_path "5090546"}
        let(:link){find("a", :text=> "Celiac Disease")}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Catalog Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Subjects Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end
    end

    context 'journal xitem detail' do
      before {visxit journals_show_path "8876278"}
      context 'Subjects' do
        let(:link){page.all(:xpath, "//a[contains(@href, 'subject')]").first}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Journals Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Subjects Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end

      context 'Author' do
        let(:link){page.all(:xpath, "//a[contains(@href, 'author_facet')]").first}
        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Journals Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Author Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end

      context 'Absorbed' do
        let(:link){page.find(:xpath, "//a[@href]", :text => "Massachusetts Instxitute of Technology. Register of graduates")}

        context 'data-ga-category' do
          xit{expect(link['data-ga-category']).to eq('Journals Item Detail')}
        end
        context 'data-ga-action' do
          xit{expect(link['data-ga-action']).to eq('Absorbed Click')}
        end
        context 'data-ga-label' do
          xit{expect(link['data-ga-label']).to eq(link.text)}
        end
      end
    end
  end

  context "Academic Commons" do
    before{visxit '/academic_commons?q=penguins'}
    context 'txitle click' do
      let(:link){page.all("a[href='http://hdl.handle.net/10022/AC:P:15583']").first}
      context 'data-ga-category' do
        xit{expect(link['data-ga-category']).to eq('Academic Commons Results List')}
      end
      context 'data-ga-action' do
        xit{expect(link['data-ga-action']).to eq('Txitle Click')}
      end
      context 'data-ga-label' do
        xit{expect(link['data-ga-label']).to eq(link.text)}
      end
    end

    context 'handle click' do
      let(:link){page.all("a[href='http://hdl.handle.net/10022/AC:P:15583']").last}
      context 'data-ga-category' do
        xit{expect(link['data-ga-category']).to eq('Academic Commons Results List')}
      end
      context 'data-ga-action' do
        xit{expect(link['data-ga-action']).to eq('Handle Click')}
      end
      context 'data-ga-label' do
        xit{expect(link['data-ga-label']).to eq("Herd Behavior, the \"Penguin Effect\", and the Suppression of Informational Diffusion: An Analysis of Informational Externalxities and Payoff Interdependency")}
      end
    end

    context 'download click', :js => true do
      before :each, :js => true do
        Capybara.default_waxit_time = 100
        expect(page).to have_xpath('//a', :text => "econ_9394_691.pdf")
        Capybara.default_waxit_time = 10
      end
      let(:link){page.find_link("econ_9394_691.pdf")}
      context 'data-ga-category', :js => true do
        xit{expect(link['data-ga-category']).to eq('Academic Commons Results List')}
      end
      context 'data-ga-action', :js => true do
        xit{expect(link['data-ga-action']).to eq('Download Click')}
      end
    end

    context 'Start Over button' do
      let(:link){find("a[href=\"\/academic_commons\"]", :text => 'Start Over')}
      context 'data-ga-category' do
        xit{expect(link['data-ga-category']).to eq('Academic Commons Results List')}
      end
      context 'data-ga-action' do
        xit{expect(link['data-ga-action']).to eq('Search Bar Click')}
      end
      context 'data-ga-label' do
        xit{expect(link['data-ga-label']).to eq('Start Over')}
      end
    end

  end
end
