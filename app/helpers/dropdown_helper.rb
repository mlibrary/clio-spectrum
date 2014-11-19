# encoding: utf-8

module DropdownHelper
  def send_to_email_dropdown_link(url)
    return (link_to "Send to Email", '#', {'data-ga-category' => "Catalog Results List",
                                          'data-ga-action' => "Selected Items",
                                          'data-ga-label' => "Send to Email",
                                          :href => url,
                                          :id => "emailLink",
                                          :name => "email",
                                          :class => "lightboxLink",
                                          :onclick => "return appendSelectedToURL(this);"})
  end

  def export_to_endnote_dropdown_link(url)
    return (link_to "Export to EndNote", '#', {'data-ga-category' => "Catalog Results List",
                                          'data-ga-action' => "Selected Items",
                                          'data-ga-label' => "Export to EndNote",
                                          :href => url,
                                          :id => "endnoteLink",
                                          :onclick => "return appendSelectedToURL(this);"})
  end

  def export_to_endnote_dropdown_link(url)
    return (link_to "Export to EndNote", '#', {'data-ga-category' => "Catalog Results List",
                                          'data-ga-action' => "Selected Items",
                                          'data-ga-label' => "Export to EndNote",
                                          :href => url,
                                          :id => "endnoteLink",
                                          :onclick => "return appendSelectedToURL(this);"})
  end

  def add_to_my_saved_list_dropdown_link
    return (link_to "Add to My Saved List", '#', {'data-ga-category' => "Catalog Results List",
                                          'data-ga-action' => "Selected Items",
                                          'data-ga-label' => "Add to My Saved List",
                                          :class => "saved_list_add",
                                          :href => '#'})
  end

  def select_all_items_dropdown_link
    return (link_to "Select All Items", '#', {'data-ga-category' => "Catalog Results List",
                                        'data-ga-action' => "Selected Items",
                                        'data-ga-label' => "Select All Items",
                                        :href => '#',
                                        :onclick => "selectAll(); return false;"})
  end

  def clear_all_items_dropdown_link
    return (link_to "Clear All Items", '#', {'data-ga-category' => "Catalog Results List",
                                        'data-ga-action' => "Selected Items",
                                        'data-ga-label' => "Clear All Items",
                                        :href => '#',
                                        :onclick => "deselectAll(); return false;"})
  end

  def link_to_with_ga(text, uri, *options)
    options_hash = Hash[*options]
    options_hash.merge!('data-ga-category' =>  "Catalog Item Detail",
    'data-ga-action' =>  "Toolbar Click",
    'data-ga-label' => text)
    return (link_to text, uri, options_hash)
  end
end
