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
      preencherRedes($("#id_rede").val(), $("#id_equipe").val())
      return

preencherResponsaveis = (responsavel_id = 0) ->

  responsaveis = $("#sub_equipe_responsavel_id")
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

preencherRedes = (rede_id = 0, equipe_id = 0) ->

  redes = $("#rede_id")
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

        redes.val(rede_id)

        preencherEquipes(equipe_id)
        return
  else
    preencherEquipes(equipe_id)
    return

  return

preencherEquipes = (equipe_id = 0) ->

  equipes = $("#sub_equipe_equipe_id")
  equipes.empty()
  equipes.append($("<option />").val(0).text("Selecione"))

  if $("#rede_id").val() != '0'
    $.ajax '/hierarquia/preencher_equipes',
      type: 'GET'
      data:
        rede_id: $("#rede_id").val()
      success: (data) ->
        $.each data, ->
          equipes.append($("<option />").val(this.id).text(this.descricao))
          return

        equipes.val(equipe_id)
        return

  return

$('#igreja_id').change ->
  preencherResponsaveis()
  preencherRedes()
  return

$('#rede_id').change ->
  preencherEquipes()
  return