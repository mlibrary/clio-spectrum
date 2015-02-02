// Lesson: You can't spy on a $(css) jQuery DOM selector, it's not an object, it's a return value.
// So instead of spying on $('.nav-collpase'), I spy on $.fn .
// http://stackoverflow.com/a/6198122/2197402

// Lesson: Event spying requires knowing the actual event triggered when the function is called.
// Calling collapse will trigger the events 'show' or 'hide'
// https://github.com/seyhunak/twitter-bootstrap-rails/blob/master/app/assets/javascripts/twitter/bootstrap/bootstrap-collapse.js#L69

describe('top navbar', function() {
  window.google_analytics_web_property_id = 'FAKEID';
  beforeEach(function() {
    loadFixtures('top_navbar/crown.html');
  });

  it('should send ga event when clicking on Suggestions & Feedback', function(){
    spyOnEvent($('.feedback-popup'),'click');
    spyOn(window, "ga");
    $('.feedback-popup').click()
    expect(window.ga).toHaveBeenCalledWith('send', 'event', 'Outbound Link', 'Top NavBar Click', 'Suggestions & Feedback' );
  });
});

describe('Academic Commons results list', function() {
  window.google_analytics_web_property_id = 'FAKEID';
  beforeEach(function() {
    loadFixtures('ac/index.html');
  });

  it('should send ga event when clicking on title', function(){
    spyOnEvent($('a'),'click');
    spyOn(window, "ga");
    $('a[href]:contains("Herd Behavior")').click()
    expect(window.ga).toHaveBeenCalledWith('send', 'event', 'Academic Commons Results List', 'Click', "Herd Behavior, the \"Penguin Effect\"");
  });

  it('should send ga event when clicking on document handle', function(){
    spyOnEvent($('a'),'click');
    spyOn(window, "ga");
    $('a[href]:contains("handle")').click()
    expect(window.ga).toHaveBeenCalledWith('send', 'event', 'Academic Commons Results List', 'Identifier Click', 'http://hdl.handle.net/10022/ActionController:P:15583');
  });

  it('should send ga event when clicking on document downloads link', function(){
    spyOnEvent($('a'),'click');
    spyOn(window, "ga");
    $('a[href]:contains("pdf")').click()
    expect(window.ga).toHaveBeenCalledWith('send', 'event', 'Academic Commons Results List', 'Downloads Click', 'econ_9394_691.pdf');
  });

});

describe('Catalog results list', function() {
  window.google_analytics_web_property_id = 'FAKEID';

  describe('within item detail', function(){
    beforeEach(function() {
      loadFixtures('catalog/index.html');
    });
    it('clicking on a link to ProQuest should generate a ga event', function(){
      spyOnEvent($('a'),'click');
      spyOn(window, "ga");
      $('a[href]:contains("Click here for full text")').click()
      expect(window.ga).toHaveBeenCalledWith('send', 'event', 'Catalog Results List', 'Online Click', 'Click here for full text.');
    });
    it('clicking on a title should not generate a ga event', function(){
      spyOnEvent($('a'),'click');
      spyOn(window, "ga");
      $('a[href]:contains("Penguins")').click()
      expect(window.ga).not.toHaveBeenCalled();
    });
  });

  describe('Selected Items Toolbar', function(){
    beforeEach(function() {
      loadFixtures('catalog/toolbar.html');
    });
    it('clicking on Send to Email should generate a ga event', function(){
      spyOnEvent($('a'),'click');
      spyOn(window, "ga");
      $('a[href]:contains("Send to Email")').click()
      expect(window.ga).toHaveBeenCalledWith('send', 'event', 'Catalog Results List', 'Selected Items Toolbar Click', 'Send to Email');
    });
  });
  describe('search bar', function(){
    beforeEach(function() {
      loadFixtures('catalog/search.html');
    });
    it('should not generate an event when searching', function(){
      spyOn(window, "ga");
      $('.basic_search_button').click()
      expect(window.ga).not.toHaveBeenCalled();
    });
  });

});
