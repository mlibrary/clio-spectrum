require 'spec_helper'

describe DropdownHelper do

  describe "#email_dropdown_link" do
    url = "/catalog/email"
    { :id => "emailLink",
      :name => "email",
      :class => "lightboxLink",
      'data-ga-category' => "Catalog Results List",
      'data-ga-action' => "Selected Items",
      'data-ga-label' => "Send to Email",
      :onclick => "return appendSelectedToURL(this);"}.each do |key, val|
      it "should have attribute #{key} with value #{val} on <a> tag" do
        link = email_dropdown_link(email_path)
        expect(link).to match /<a [^>]*#{escape_parens(key.to_s)}=\"#{escape_parens(val)}\"/
      end
#      <a href="http://localhost:3000/catalog/email?id[]=4359539" class="lightboxLink" id="emailLink" name="email" onclick="return appendSelectedToURL(this);">Send to Email</a>
    end
    it 'should have text Send to Email for <a> tag' do
      link = email_dropdown_link(url)
      expect(link).to match /<a [^>]*>Send to Email/
    end
    it 'should have href to path' do
      link = email_dropdown_link(email_path("12345"))
      expect(link).to match /<a [^>]*href=\"#{email_path("12345")}/
    end
  end
end
def escape_parens(str)
  str.gsub(/[()\[\]]/, '(' => '\(', ')' => '\)', '\[' => '\[', '\]' => '\]')
end
