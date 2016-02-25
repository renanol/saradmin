# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

if($('#arquivo').val() != null && $('#arquivo').val() == 'new-edit-form')
  $.ajax '/hierarquia/preencher_igrejas',
    type: 'GET'
    success: (data) ->
      igrejas = $("#rede_igreja_id")
      igrejas.empty()
      igrejas.append($("<option />").val(0).text("Selecione"))

      $.each data, ->
        igrejas.append($("<option />").val(this.id).text(this.descricao))

      igrejas.val($("#id_igreja").val())

      preencherResponsaveis($("#id_responsavel").val())
      return

preencherResponsaveis = (responsavel_id = 0) ->

  responsaveis = $("#rede_responsavel_id")
  responsaveis.empty()
  responsaveis.append($("<option />").val(0).text("Selecione"))

  if $("#rede_igreja_id").val() != '0'
    $.ajax '/hierarquia/preencher_responsaveis',
      type: 'GET'
      data:
        igreja_id: $("#rede_igreja_id").val()
      success: (data) ->
        $.each data, ->
          responsaveis.append($("<option />").val(this.id).text(this.nome))
          return

        responsaveis.val(responsavel_id)
        return

  return

$('#rede_igreja_id').change ->
  preencherResponsaveis()
  return