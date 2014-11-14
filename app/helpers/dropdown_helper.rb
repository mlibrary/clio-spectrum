# encoding: utf-8

module DropdownHelper
  def email_dropdown_link(url)
    return (link_to "Send to Email", '#', {'data-ga-category' => "Catalog Results List",
                                          'data-ga-action' => "Selected Items",
                                          'data-ga-label' => "Send to Email",
                                          :href => url,
                                          :id => "emailLink",
                                          :name => "email",
                                          :class => "lightboxLink",
                                          :onclick => "return appendSelectedToURL(this);"})
  end
end
