$ ->
  update_record_request_visibility()


  
  $('.turn_async_off').hide()

  $('.radio-record_request input[type=radio]').click ->
    update_record_request_visibility()

root = exports ? this
root.update_record_request_visibility = ->
  val = $('.radio-record_request input[type=radio]:checked').val()
  $('.record_request_form:not(.' + val + ')').hide()
  $('.record_request_form.' + val).show()

