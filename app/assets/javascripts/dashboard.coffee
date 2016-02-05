# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.uf-select').change ->
  city_id = $(this).data("city-select")
  uf_id = $(this).val()
  id = $(this).data('indice')

  if uf_id == "-1"
    $('#show-estado-'+id).removeClass('hide')
  else
    $('#show-estado-'+id).addClass('hide')

  $.ajax '/igrejas/buscar_cidades',
    type: 'GET'
    contentType: "application/json"
    dataType: "json"
    data: {
      estado_id: uf_id
    }
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("AJAX Error: #{textStatus}")
    success: (data, textStatus, jqXHR) ->
      $("#" + city_id).empty()
      for cidade in data
        $("#" + city_id).append($("<option />").val(cidade.id).text(cidade.nome));

$('.pais-select').change ->
  estado_id = $(this).data("estado-select")
  pais_id = $(this).val()
  id = $(this).data('indice')

  $.ajax '/igrejas/buscar_estados',
    type: 'GET'
    contentType: "application/json"
    dataType: "json"
    data: {
      pais_id: pais_id
    }
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("AJAX Error: #{textStatus}")
    success: (data, textStatus, jqXHR) ->
      $("#" + estado_id).empty()
      for cidade in data
        $("#" + estado_id).append($("<option />").val(cidade.id).text(cidade.nome));


$('.cidade-select').change ->
  bairro_id = $(this).data("bairro-select")
  cidade_id = $(this).val()

  $.ajax '/igrejas/buscar_bairros',
    type: 'GET'
    contentType: "application/json"
    dataType: "json"
    data: {
      cidade_id: cidade_id
    }
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("AJAX Error: #{textStatus}")
    success: (data, textStatus, jqXHR) ->
      $("#" + bairro_id).empty()
      for cidade in data
        $("#" + bairro_id).append($("<option />").val(cidade.id).text(cidade.nome));

