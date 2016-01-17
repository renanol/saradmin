# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.uf-select').change ->
  city_id = $(this).data("city-select")
  uf_id = $(this).val()
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