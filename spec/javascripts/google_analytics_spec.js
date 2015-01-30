// Lesson: You can't spy on a $(css) jQuery DOM selector, it's not an object, it's a return value.
// So instead of spying on $('.nav-collpase'), I spy on $.fn .
// http://stackoverflow.com/a/6198122/2197402

// Lesson: Event spying requires knowing the actual event triggered when the function is called.
// Calling collapse will trigger the events 'show' or 'hide'
// https://github.com/seyhunak/twitter-bootstrap-rails/blob/master/app/assets/javascripts/twitter/bootstrap/bootstrap-collapse.js#L69

describe('Google Analytics top navbar', function() {
  window.google_analytics_web_property_id = 'FAKEID';
  beforeEach(function() {
    loadFixtures('top_navbar/crown.html');
  });

  it('should send ga event when clicking on Suggestions & Feedback', function(){
    spyOnEvent($('.feedback-popup'),'click');
    spyOn(window, "ga");
    $('.feedback-popup').click()
    expect(window.ga).toHaveBeenCalledWith('send', 'event', 'Outbound Link', 'Click', 'Suggestions & Feedback' );
  });
});

