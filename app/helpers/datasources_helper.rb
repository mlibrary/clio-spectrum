# encoding: UTF-8
module DatasourcesHelper

  def datasource_list(category = :all)
    FOCUS_CONFIG.by_category(category).map { |item| item.name }
  end

  def active_query?
    !( params['q'].to_s.empty? &&
       params.keys.all? { |k| !k.include?('s.') } &&
       params['f'].to_s.empty? &&
       params['commit'].to_s.empty?
    )
  end

  # switch from loading all landing-pages/switching via javascript
  # to loading only single-source landing-page, select with page-fetch
  # def add_all_datasource_landing_pages
  #   content_tag('div', :class => 'landing_pages') do
  #     datasource_list(:all).collect do |source|
  #       datasource_landing_page(source)
  #     end.join('').html_safe
  #   end
  # end

  # Output the HTML of a single landing page for the passed data-source
  def datasource_landing_page(source = @active_source)
    content_tag('div', class: 'landing_pages') do
      classes = ['landing_page', source]
      classes << 'selected' if source == @active_source
      warning = FOCUS_CONFIG[source].warning
      content_tag(
        :div,
        render(
          partial: "/_search/landing_page",
          locals: {
            source: source,
            warning: warning,
            title: FOCUS_CONFIG[source].title,
            description: FOCUS_CONFIG[source].description
           }
        ),
        class: classes.join(' '),
        data: { 'ga-action' => 'Landing Page Click' }
      )
    end
  end

  def datasources_active_list(options = {})
    if options[:all_sources]
      datasource_list(:all)
    else
      datasource_list(:major) |
      datasource_list(:minor).select { |source| source == options[:active_source] }
    end
  end

  # Return a list of datasources which are "hidden" beneath the "More..." expander
  def datasources_hidden_list(options = {})
    if options[:all_sources]
      []
    else
      datasource_list(:minor).reject { |source| source == options[:active_source] }
    end
  end

  # Called from several layouts to add the stack of datasources to the sidebar.
  # Takes as arg the source to mark as active.
  # Returns an HTML <UL> list of datasources
  def add_datasources(active_source = @active_source)
    options = {
      active_source: active_source,
      query: params['q'] || params['s.q'] || ''
    }

    has_facets = source_has_facets?(active_source)
    # Show all datasources when there's no current query, or
    # when we're in a datasource that doesn't have facets.
    options[:all_sources] = !active_query? || !has_facets

    result = []
    result |= datasources_active_list(options).map do |src|
      single_datasource_list_item(src, options)
    end

    # If there are hidden data-sources, gather them up wrapped w/ expand/contract links
    unless (hidden_datasources = datasources_hidden_list(options)).empty?
      result << content_tag(:li, link_to('More...', '#'),  id: 'datasource_expand')

      sub_results = hidden_datasources.map do |src|
        single_datasource_list_item(src, options)
      end

      sub_results << content_tag(:li, link_to('Fewer...', '#'), id: 'datasource_contract')
      result << content_tag(:ul, sub_results.join('').html_safe, id: 'expanded_datasources', class: 'list-unstyled')
    end

    landing_class = options[:all_sources] ? 'landing datasource_list' : 'datasource_list'
    landing_class += ' no_facets' unless has_facets
    landing_class += ' hidden-xs'
    clio_sidebar_items.unshift(
      content_tag(:ul, result.join('').html_safe, id: 'datasources', class: landing_class)
    )
  end

  def sidebar_span(source = @active_source)
    # source_has_facets?(source) ? 'col-sm-3' : 'span2_5'
    # Our local custom span2_5/span9_5 broke with Bootstrap 3
    'col-sm-3'
  end

  def main_span(source = @active_source)
    # source_has_facets?(source) ? 'col-sm-9' : 'span9_5'
    # Our local custom span2_5/span9_5 broke with Bootstrap 3
    'col-sm-9'
  end

  # Will there be any facets shown for this datasource?
  # No, if we're on the landing page, or if the datasource has no facets.
  # Otherwise, yes.
  def source_has_facets?(source = @active_source)
    # old mystery
    # (@has_facets || !DATASOURCES_CONFIG['datasources'][source]['no_facets'] && !@show_landing_pages)

    # mysterious
    # return true if @has_facets

    # No facets if we're showing the landing pages instead of query results
    return false if @show_landing_pages

    # No facets, if this datasource explicitly says so
    FOCUS_CONFIG[source].has_facets?
  end

  # Build up the HTML of a single datasource link, to be used along the left-side menu.
  # Should be an <li>, with an <a href> inside it.
  # The link should re-run the current search against the new data-source.
  def single_datasource_list_item(source, options)
    classes = []
    classes << 'minor_source' if options[:minor]
    query = options[:query]

# DATASOURCES_CONFIG['datasource_bar']['major_sources']

    li_classes = %w(datasource_link)
    li_classes << 'selected' if source == options[:active_source]

    # li_classes << 'subsource' if options[:subsource]
    li_classes << 'subsource' if FOCUS_CONFIG[source].subsource

    fail "no source data found for #{source}" unless FOCUS_CONFIG.has_key? source
    content_tag(
      :li,
      link_to(
        FOCUS_CONFIG[source].title,
        config.relative_url_root + FOCUS_CONFIG[source].path(query),
        class: classes.join(' ')
      ),
      source: source,
      class: li_classes.join(' ')
    )
  end

  def datasource_landing_page_path(source, query = '')
    FOCUS_CONFIG[source].path(query)
  end

  def datasource_switch_link(title, source, *args)
    options = args.extract_options!
    options[:class] ||= ''
    options[:class] += ' datasource_link'
    options[:source] = source

    # link_to title, "#", options
    link_to title, source, options
  end

  # Used for building cache keys, following suggestions from:
  #    http://veerasundaravel.wordpress.com/2012/10/10
  # Fix bug of crawlers submitting bad params to landing-pages, creating
  # cached version of landing page with (invalid) embedded hidden query params.
  def params_digest
    return Digest::SHA1.hexdigest(params.sort.flatten.join("_"))
  end
end
