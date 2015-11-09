# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
user_id = 0
grupo_id = 0

$ ->
  $('.btn-change-grupo').click ->
    grupo_id = $(this).data('grupo-id')
    user_id = $(this).data('user-id')
    user_name = $(this).data('user-name')
    $('#params_grupo_id').val(grupo_id)
    $('#user-span').text(user_name)
    $('.modal-alterar-grupo').modal()

  $('.btn-confirm-change-grupo').click ->
    form = document.getElementById('listar-form')
    form.action = '/usuarios/' + user_id + '/change_grupo?grupo_id=' + $('#params_grupo_id').val()
    form.submit()