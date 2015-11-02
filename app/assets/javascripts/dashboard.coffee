# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'change', '#estados_select', (evt) ->
    $.ajax '/igrejas/buscar_cidades',
      type: 'GET'
      contentType: "application/json"
      dataType: "json"
      data: {
        estado_id: $("#estados_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        $("#cidades_select").empty()
        for cidade in data
          $("#cidades_select").append($("<option />").val(cidade.id).text(cidade.nome));

