# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(".btn-report").on("click", ->
  $('form').get(0).setAttribute('action', $(this).data('action'))
  $('form').get(0).setAttribute('target', '_blank')
  $(this).closest("form").submit()
  return
)