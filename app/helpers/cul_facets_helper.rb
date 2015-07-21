module CulFacetsHelper
  
  # 
  ##  OVERRIDE Blacklight::FacetsHelperBehavior 
  # 
  # Are any facet restrictions for a field in the query parameters?
  # 
  # @param [String] facet field
  # @return [Boolean]
  # def facet_field_in_params? field
  #   # Support positive or negative, that is, "-location_facet"
  #   params[:f] and ( params[:f][field] || params[:f]["-#{field}"])
  # end
  
  ##
  # Check if the query parameters have the given facet field with the 
  # given value.
  # 
  # @param [Object] facet field
  # @param [Object] facet value
  # @return [Boolean]
  def facet_in_params?(field, item)
    if item and item.respond_to? :field
      field = item.field
    end

    value = facet_value_for_facet_item(item)

    return true if facet_field_in_params?(field) and params[:f][field].include?(value)

    negated_field = "-#{field}"
    # Can't do this - blacklight_range_limit assumes that the string
    # passed in to facet_field_in_params?() is a valid Solr field name.
    # return true if facet_field_in_params?(negated_field) and params[:f][negated_field].include?(value)

    return true if params[:f] and params[:f][negated_field] and params[:f][negated_field].include?(value)

    return false
  end

  # Based on Blacklight::FacetsHelperBehavior.render_selected_facet_value()
  def render_selected_excluded_facet_value(excluded_solr_field, item)

   # OLD:
    # -# %span.selected
    # -#   NOT #{value}
    # -#   = link_to content_tag(:i, '', :class => "icon-remove") + content_tag(:span, '[remove]', :class => 'hide-text'), remove_facet_params(excluded_solr_field, value, params)

    content_tag(:span, :class => "facet-label") do
      content_tag(:span, "NOT #{facet_display_value(excluded_solr_field, item)}", :class => "selected") +
      # remove link
      link_to(
        content_tag(:span, '', :class => "glyphicon glyphicon-remove") + content_tag(:span, '[remove]', :class => 'sr-only'),
        config.relative_url_root + search_action_path(remove_facet_params(excluded_solr_field, item, params)),
        :class => "remove"
      )
    end
  end

  ##
  # Standard display of a SELECTED facet value (e.g. without a link and with a remove button)
  # @params (see #render_facet_value)
  def render_selected_facet_value(facet_solr_field, item)
    content_tag(:span, :class => "facet-label") do
      content_tag(:span, facet_display_value(facet_solr_field, item), :class => "selected") +
      # remove link
      link_to(
        content_tag(:span, '', :class => "glyphicon glyphicon-remove") + content_tag(:span, '[remove]', :class => 'sr-only'),
        config.relative_url_root + search_action_path(remove_facet_params(facet_solr_field, item, params)),
        :class => "remove"
      )
    end + render_facet_count(item.hits, :classes => ["selected"])
  end

  ##
  # Standard display of a facet value in a list. Used in both _facets sidebar
  # partial and catalog/facet expanded list. Will output facet value name as
  # a link to add that to your restrictions, with count in parens.
  #
  # @param [Blacklight::SolrResponse::Facets::FacetField]
  # @param [String] facet item
  # @param [Hash] options
  # @option options [Boolean] :suppress_link display the facet, but don't link to it
  # @return [String]
  def render_facet_value(facet_solr_field, item, options ={})
    path = search_action_path(add_facet_params_and_redirect(facet_solr_field, item))
    content_tag(:span, :class => "facet-label") do
      link_to_unless(
        options[:suppress_link],
        facet_display_value(facet_solr_field, item),
        config.relative_url_root + path,
        :class => "facet_select"
      )
    end + render_facet_count(item.hits)
  end

  # Override core blacklight render_constraints_helper_behavior.rb
  # module Blacklight::RenderConstraintsHelperBehavior#render_filter_element
  def render_filter_element(facet, values, localized_params)
    is_negative = (facet =~ /^-/) ? 'NOT ' : ''
    proper_facet_name = facet.gsub(/^-/, '')

    facet_config = facet_configuration_for_field(proper_facet_name)

    values.map do |val|

      render_constraint_element(
        facet_field_label(proper_facet_name),
        is_negative + facet_display_value(proper_facet_name, val),
        remove: url_for(remove_facet_params(facet, val, localized_params)),
        classes: ['filter', 'filter-' + proper_facet_name.parameterize]
      ) + "\n"
    end
  end

  def expand_all_facets?
    get_browser_option('always_expand_facets') == 'true'
  end

  def build_facet_tag(facet_field, datasource = @active_source)
    facet_field_label = if facet_field.is_a? String
      facet_field
    elsif facet_field.respond_to?(:field)
      facet_field.field
    elsif facet_field.respond_to?(:display_name)
      facet_field.display_name
    elsif facet_field.respond_to?(:field_name)
      facet_field.field_name
    else
      ""
      raise
    end
    # facet_tag = @active_source + '_' + facet_field.field.parameterize
    facet_tag = @active_source + '_' + facet_field_label
  end

  ##
  ##   #####   BLACKLIGHT 5    #####
  ##   override Blacklight::FacetsHelperBehavior, 
  ##   to add support for NEXT-1028
  ##
  # Determine whether a facet should be rendered as collapsed or not.
  #   - if the facet is 'active', don't collapse
  #   - if the facet is configured to collapse (the default), collapse
  #   - if the facet is configured not to collapse, don't collapse
  # 
  # @param [Blacklight::Configuration::FacetField]
  # @return [Boolean]
  # 
  # Columbia Override
  # Accept a Blacklight Facet, a Summon Facet, or a String
  # Check against our Browser Options
  def should_collapse_facet? facet_field

    # 1) If the facet is 'active', don't collapse

    # For Summon Facets
    if facet_field.respond_to?(:has_applied_value?)
      return false if facet_field.has_applied_value?
    end
    # For Blacklight Facets
    if facet_field.respond_to?(:field)
      return false if facet_field_in_params?(facet_field.field)
    end

    # 2) Columbia - check browser options for display preference
    # NEXT-1028 - Make facet state (open/closed) sticky through a selection
    # Do we have an explicit browser-display setting saved?
    # If so, respect that saved setting ("Sticky").
    facet_tag = build_facet_tag(facet_field, @active_source)
    return false if get_browser_option(facet_tag) == 'open'
    return true if get_browser_option(facet_tag) == 'closed'


    # 3) "if the facet is configured..."
    # Last fall-back, if the facet has a config option, respect it
    if facet_field.respond_to?(:collapse)
      return facet_field.collapse
    end

    # Default state if nothing indicates otherwise....
    return true
  end


  # # Is there something telling us to render this facet as open?
  # def render_facet_open?(facet_field, datasource = @active_source)
  #   # Do we have "Expand All Facets" turned on?
  #   return true if expand_all_facets?
  # 
  #   # Is the facet itself configured to display as open?
  #   return true if facet_field && facet_field.respond_to?(:open) && facet_field.open == true
  # 
  #   # NEXT-1028 - Make facet state (open/closed) sticky through a selection
  #   # Do we have an explicit browser-display setting saved?
  #   # If so, respect that saved setting ("Sticky").
  #   facet_tag = build_facet_tag(facet_field, datasource)
  #   return true if get_browser_option(facet_tag) == 'open'
  #   return false if get_browser_option(facet_tag) == 'closed'
  # 
  #   # Nothing told us to render this facet as open, so it'll be closed.
  #   false
  # end
end
