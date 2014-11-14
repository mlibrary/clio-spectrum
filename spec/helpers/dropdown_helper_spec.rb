require 'spec_helper'

describe DropdownHelper do

  {
    'Send to Email' => { 
                        :id => "emailLink",
                        'href' => "/catalog/email",
                        :name => "email",
                        :class => "lightboxLink",
                        'data-ga-category' => "Catalog Results List",
                        'data-ga-action' => "Selected Items",
                        'data-ga-label' => "Send to Email",
                        :onclick => "return appendSelectedToURL(this);"
    },

    'Export to EndNote' => {
                            :id => 'endnoteLink',
                            'href' => "/catalog/email",
                            'data-ga-category' => "Catalog Results List",
                            'data-ga-action' => "Selected Items",
                            'data-ga-label' => "Export to EndNote",
                            :onclick => "return appendSelectedToURL(this);"
    },

    'Add to My Saved List' => {
                            :class => 'saved_list_add',
                            'href' => '#',
                            'data-ga-category' => "Catalog Results List",
                            'data-ga-action' => "Selected Items",
                            'data-ga-label' => "Add to My Saved List"
    },

    'Select All Items' => {
                            :onclick => "selectAll(); return false;",
                            'data-ga-category' => "Catalog Results List",
                            'data-ga-action' => "Selected Items",
                            'data-ga-label' => "Select All Items"
    },

    'Clear All Items' => {
                            :onclick => "deselectAll(); return false;",
                            'data-ga-category' => "Catalog Results List",
                            'data-ga-action' => "Selected Items",
                            'data-ga-label' => "Clear All Items"
    }
    }.each do |key1, val1|
      method_name = "#{key1.gsub(/ /,'_').downcase}_dropdown_link"
      url = ((key1 == 'Send to Email' || key1 == 'Export to EndNote') ? "/catalog/email" : nil)
      describe "##{method_name}" do
        val1.each do |key, val|
        it "should have attribute #{key} with value #{val} on <a> tag" do
          if url
            link = send(method_name.to_sym, url)
          else
            link = send(method_name.to_sym)
          end
          expect(link).to match /<a [^>]*#{escape_parens(key.to_s)}=\"#{escape_parens(val)}\"/
        end
#      <a href="http://localhost:3000/catalog/email?id[]=4359539" class="lightboxLink" id="emailLink" name="email" onclick="return appendSelectedToURL(this);">Send to Email</a>
        end
        it "<a> tag should have text #{key1}" do
          if url
            link = send(method_name.to_sym, url)
          else
            link = send(method_name.to_sym)
          end
          expect(link).to match /<a [^>]*>#{key1}/
        end
        it "should have href to path" do
          if url
            link = send(method_name.to_sym, url)
          else
            link = send(method_name.to_sym)
          end
          expect(link).to match /<a [^>]*href=\"#{url}/
        end
      end
    end
  end

def escape_parens(str)
  str.gsub(/[()\[\]]/, '(' => '\(', ')' => '\)', '\[' => '\[', '\]' => '\]')
end
