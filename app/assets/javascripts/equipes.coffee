# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
if($('#arquivo').val() != null && $('#arquivo').val() == 'new-edit-form')
  $.ajax '/hierarquia/preencher_igrejas',
    type: 'GET'
    success: (data) ->
      igrejas = $("#igreja_id")
      igrejas.empty()
      igrejas.append($("<option />").val(0).text("Selecione"))

      $.each data, ->
        igrejas.append($("<option />").val(this.id).text(this.descricao))

      igrejas.val($("#id_igreja").val())

      preencherResponsaveis($("#id_responsavel").val())
      preencherRedes($("#id_rede").val())
      return

preencherResponsaveis = (responsavel_id = 0) ->

  responsaveis = $("#equipe_responsavel_id")
  responsaveis.empty()
  responsaveis.append($("<option />").val(0).text("Selecione"))

  if $("#igreja_id").val() != '0'
    $.ajax '/hierarquia/preencher_responsaveis',
      type: 'GET'
      data:
        igreja_id: $("#igreja_id").val()
      success: (data) ->
        $.each data, ->
          responsaveis.append($("<option />").val(this.id).text(this.nome))
          return

        responsaveis.val(responsavel_id)
        return

  return

preencherRedes = (rede_id = 0) ->

  redes = $("#equipe_rede_id")
  redes.empty()
  redes.append($("<option />").val(0).text("Selecione"))

  if $("#igreja_id").val() != '0'
    $.ajax '/hierarquia/preencher_redes',
      type: 'GET'
      data:
        igreja_id: $("#igreja_id").val()
      success: (data) ->
        $.each data, ->
          redes.append($("<option />").val(this.id).text(this.descricao))
          return

        redes.val(rede_idsponsavel_id)
        return

  return

$('#igreja_id').change ->
  preencherResponsaveis()
  preencherRedes()
  return