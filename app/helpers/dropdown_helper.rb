# encoding: utf-8

module DropdownHelper
  def link_to_item_detail_with_ga(text, uri, *options)
    options_hash = Hash[*options]
    options_hash.merge!('data-ga-category' =>  ga_category_for_item_detail,
    'data-ga-action' =>  "Toolbar Click",
    'data-ga-label' => text)
    return (link_to text, uri, options_hash)
  end
  def link_to_item_list_with_ga(text, uri, *options)
    options_hash = Hash[*options]
    options_hash.merge!('data-ga-category' => ga_category_for_results_list,
    'data-ga-action' =>  "Selected Items",
    'data-ga-label' => text)
    return (link_to text, uri, options_hash)
  end
end
