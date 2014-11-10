$(document).change(function() {
  $('a[href]').filter( function() {return this.hostname && this.hostname !== location.hostname} ).each(function() {

    // var href   = $(this).attr("href");
    // var target = $(this).attr("target");
    // var text   = $(this).text();
    // console.log("found a.href href=["+href+"] text=["+text+"]")

    $(this).click(function(event) { // when someone clicks these links
      // Gather up values at time of click, not at first load, to allow
      // for ajax updates to, e.g., href labels or targets

      var href   = $(this).attr("href");
      var target = $(this).attr("target");
      var text   = $(this).text();

      // The GA Category/Action may be given at a higher DOM level,
      // e.g., at the root of an html menu/list of links, or a container div,
      var category = $(this).closest("[data-ga-category]").data("ga-category") || "Outbound Link";
      var action = $(this).closest("[data-ga-action]").data("ga-action") || "Click";
      // Should the GA label default to the text or the URL?
      var label = $(this).data("ga-label") || text;

      event.preventDefault(); // don't open the link yet

      // console.log("ga('send','event','"+category+"','"+action+"','"+label+"')")
      ga('send', 'event', category, action, label);

      setTimeout(function() { // now wait 300 milliseconds...
        window.open(href, (!target ? "_blank" : target)); // ...and open in new blank window
      },300);
    });
  });


});






