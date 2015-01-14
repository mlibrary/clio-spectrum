# encoding: utf-8

module DropdownHelper
  def link_to_item_detail_with_ga(text, uri, *options)
    options_hash = Hash[*options]
    return (link_to text, uri, options_hash)
  end
  def link_to_item_list_with_ga(text, uri, *options)
    options_hash = Hash[*options]
    return (link_to text, uri, options_hash)
  end
end
