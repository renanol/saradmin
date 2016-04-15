# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
if($('#arquivo').val() != null && $('#arquivo').val() == 'idx-form')
  $.ajax '/hierarquia/preencher_igrejas',
    type: 'GET'
    success: (data) ->
      igrejas = $("#igreja_id")
      igrejas.empty()
      igrejas.append($("<option />").val(0).text("Selecione"))

      $.each data, ->
        igrejas.append($("<option />").val(this.id).text(this.descricao))
        return

      igrejas.val(0)
      return

  $.ajax '/hierarquia/preencher_cargos',
    type: 'GET'
    success: (data) ->
      cargos = $("#cargo_id")
      cargos.empty()
      cargos.append($("<option />").val(0).text("Selecione"))

      $.each data, ->
        cargos.append($("<option />").val(this.id).text(this.descricao))
        return

      cargos.val(0)
      return

preencherResponsaveis = ->

  responsaveis = $("#responsavel_id")
  responsaveis.empty()
  responsaveis.append($("<option />").val(0).text("Selecione"))

  $.ajax '/hierarquia/preencher_responsaveis',
    type: 'GET'
    data:
      igreja_id: $("#igreja_id").val()
    success: (data) ->
      $.each data, ->
        responsaveis.append($("<option />").val(this.id).text(this.nome))
        return

      responsaveis.val(0)
      return

  return

preencherRedes = ->

  redes = $("#rede_id")
  redes.empty()
  redes.append($("<option />").val(0).text("Selecione"))

  $.ajax '/hierarquia/preencher_redes',
    type: 'GET'
    data:
      igreja_id: $("#igreja_id").val()
    success: (data) ->
      $.each data, ->
        redes.append($("<option />").val(this.id).text(this.descricao))
        return

      redes.val(0)
      return

  return

preencherEquipes = ->

  equipes = $("#equipe_id")
  equipes.empty()
  equipes.append($("<option />").val(0).text("Selecione"))

  $.ajax '/hierarquia/preencher_equipes',
    type: 'GET'
    data:
      rede_id: $("#rede_id").val()
    success: (data) ->
      $.each data, ->
        equipes.append($("<option />").val(this.id).text(this.descricao))
        return

      equipes.val(0)
      return

  return

preencherSubEquipes = ->

  sub_equipes = $("#sub_equipe_id")
  sub_equipes.empty()
  sub_equipes.append($("<option />").val(0).text("Selecione"))

  $.ajax '/hierarquia/preencher_sub_equipes',
    type: 'GET'
    data:
      equipe_id: $("#equipe_id").val()
    success: (data) ->
      $.each data, ->
        sub_equipes.append($("<option />").val(this.id).text(this.descricao))
        return

      sub_equipes.val(0)

      return

  return

preencherCelulas = ->

  celulas = $("#celula_id")
  celulas.empty()
  celulas.append($("<option />").val(0).text("Selecione"))

  $.ajax '/hierarquia/preencher_celulas',
    type: 'GET'
    data:
      sub_equipe_id: $("#sub_equipe_id").val()
    success: (data) ->
      $.each data, ->
        celulas.append($("<option />").val(this.id).text(this.descricao))
        return

      celulas.val(0)
      return

  return

$('#igreja_id').change ->
  preencherResponsaveis()
  preencherRedes()
  return

$('#rede_id').change ->
  preencherEquipes()
  return

$('#equipe_id').change ->
  preencherSubEquipes()
  return

$('#sub_equipe_id').change ->
  preencherCelulas()
  return

$(".btn-report").on("click", ->
  $('form').get(0).setAttribute('action', $(this).data('action'))
  $('form').get(0).setAttribute('target', '_blank')
  $(this).closest("form").submit()
  return
)