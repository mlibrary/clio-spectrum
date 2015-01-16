$(document).ready(function() {

  // UNIVERSAL TRACKING CODE FROM GA WEBSITE

  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  // Point our running instance to the appropriate GA property definition
  ga('create', google_analytics_web_property_id, 'columbia.edu');

  // FOR LOCALHOST DEVELOPMENT USE THIS LINE INSTEAD
  // ga('create', google_analytics_web_property_id, 'none');

  // This sends the a normal page-view to Google Analytics.
  // It runs once on page load.
  ga('send', 'pageview');


  // The below attaches a Click-handler function to selected <A HREF> links,
  // which will send a GA custom event when that link is clicked.

  // Click-Tracking as GA Events, based on:
  //   http://www.lunametrics.com/blog/2013/07/02/jquery-event-tracking
  // Apply to all off-site <A> tags, based on:
  //   http://www.electrictoolbox.com/jquery-open-offsite-links-new-window/

  $(document).on('click', 'a', function(event) {

    // Gather up values at time of click, not at first load, to allow
    // for ajax updates to, e.g., href labels or targets

    var href   = $(this).attr("href");
    var target = $(this).attr("target");
    var text   = $(this).text();

    // The GA Category/Action may be given at a higher DOM level,
    // e.g., at the root of an html menu/list of links, or a container div,

    var category = $(this).closest("[data-ga-category]").data("ga-category") || "Outbound Link";
    var action = $(this).closest("[data-ga-action]").data("ga-action") || "Click";
    var label = $(this).data("ga-label") || text;

    // if click also activates a page load, stash the values and submit when page reloads

    if (action.match(/Display Options/)||action.match(/Sort by/)||label.match(/MARC View/)){
      if (label != 'Export to EndNote'){
        logToConsole("stashing ga('send','event','"+category+"','"+action+"','"+label+"')");
        sessionStorage.setItem('data-ga-category', category);
        sessionStorage.setItem('data-ga-action', action);
        sessionStorage.setItem('data-ga-label', label);
      }
      return;
    }

    var open_new_window = false;
    // Offsite links will open a new window unless it is a download link

    if ((this.hostname && this.hostname !== location.hostname) && action != "Download Click"){
      open_new_window = true;
    }

    if (open_new_window){
      event.preventDefault(); // don't open the link yet
    }

    logToConsole("ga('send','event','"+category+"','"+action+"','"+label+"')");
    ga('send', 'event', category, action, label, {useBeacon: true});

    if (open_new_window){
      setTimeout(function() { // now wait 300 milliseconds...
        window.open(href, (!target ? "_blank" : target)); // ...and open in new blank window
      },300);
    }
  });


  $(this).bind('copy', function() {
    var selectedText = "";
    if (window.getSelection) {
        selectedText = window.getSelection().toString();
    } else if (document.selection && document.selection.type != "Control") {
        selectedText = document.selection.createRange().text;
    }
    if (selectedText.length > 0) {
      // console.log('copy event')
      // What GA category/action/label do we want to log this event as?
    }
    return true;
  });

  $(window).load(function(event) {

    // get selected source from sidebar and label from URL

    var source = $(document).find('#sources').find('.datasource_link.selected').text();

    // is it a search result page?


    var category = "Search Results Load";
    var action = source;
    var label = document.URL;
    var advanced = false;

    // is there an event stashed away?

    if (sessionStorage.getItem('data-ga-category')){
      category = sessionStorage.getItem('data-ga-category');
      action = sessionStorage.getItem('data-ga-action');
      label = sessionStorage.getItem('data-ga-label');
      logToConsole("sending stashed event: ga('send','event','"+category+"','"+action+"','"+label+"')");
      ga('send', 'event', category, action, label, {useBeacon: true});
      sessionStorage.removeItem('data-ga-category');
      sessionStorage.removeItem('data-ga-action');
      sessionStorage.removeItem('data-ga-label');
      return;
    }

    if (!$('.result')) {
      return;
    }

    if ((getQueryVariable('advanced_operator'))|| (getQueryVariable('form') == 'advanced')){
      advanced = true;
    }
    // zero-hits search?

    if ($('div.result_empty').length > 0){
      category += " - Zero Hits";
      if (advanced){
        action = action + ' Advanced';
      }
      else{
        action = action + ' Basic';
      }
      logToConsole("ga('send','event','"+category+"','"+action+"','"+label+"')");
      ga('send', 'event', category, action, label, {useBeacon: true});
    }
    else{

      // return if it is not a search results page

      if ($('.index_toolbar').length === 0 ){
        return;
      }

      var hits = 0;
      var num_hits = 0;

      // Zero Hits Search?

      if ($('.page_entries').length > 0){
        num_hits = $('.page_entries').text().replace(/ /g,'').replace(/\|/g,'').split('of')[1].trim();
      }
      else {
        num_hits = $('#current_item_info').text().replace(/ /g,'').replace(/\|/g,'').split('of')[1].trim();
      }
      if (advanced){
        action = action + ' Advanced ('+ num_hits+' hits)';
        advanced_operator = getQueryVariable('advanced_operator')|| ' OR ';
      }
      else{
        action = action + ' Basic ('+ num_hits+' hits)';
      }
      logToConsole("ga('send','event','"+category+"','"+action+"','"+label+"')");
      ga('send', 'event', category, action, label, {useBeacon: true});
    }
  });

    //Quicksearch and other aggregate searchresults are loaded by ajax

    $(document).ajaxComplete(function(event, xhr, settings) {

      var resp = jQuery.parseHTML(xhr.responseText);
      if ($(resp).find('.results_header').length <= 0){
        return;
      }
      var selected = $(document).find('#sources').find('.datasource_link.selected').text();
      var source='';
      var src='';
        source = $(resp).find('div[data-source]').attr('data-source');
      if (source){
        src = source.split("_").map(function(i){return i[0].toUpperCase() + i.substring(1)}).join(" ");
      }
      var category = "Search Results Load";
      var action = selected + ': ' + src;
      var label = document.URL;

      // Zero Hits Search?

      if ($(resp).find('div.result_empty').length > 0){
        category += " - Zero Hits";
        logToConsole("ga('send','event','"+category+"','"+action+"','"+label+"')");
        ga('send', 'event', category, action, label, {useBeacon: true});
      }
      else{
        if (source){
          num_hits = $(resp).find('div[data-source] > div.result_count').find('a > span.hidden-xs').text();
          if (num_hits){
            hits = num_hits;
          }
          action += ' ' + hits + " Hits";
          label = settings.url;
          logToConsole("ga('send','event','"+category+"','"+action+"','"+label+"')");
          ga('send', 'event', category, action, label, {useBeacon: true});
        }
      }

    });

  });

  function logToConsole(message)
  {
    if ($("body").data("rails-env") == 'development')
      {
        console.log(message)
      }
  }
function getQueryVariable(variable)
{
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
    var pair = vars[i].split("=");
    if(decodeURI(pair[0]) == variable){return decodeURI(pair[1]);}
  }
  return(false);
}
