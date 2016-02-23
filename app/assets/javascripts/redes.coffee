# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

if($('#arquivo').val() != null && $('#arquivo').val() == 'new-edit-form')
  rede_id = $('#id').val()

  if rede_id == undefined || rede_id == null || rede_id == ''
    alert 'nova rede'
  else
    alert 'rede ' + rede_id