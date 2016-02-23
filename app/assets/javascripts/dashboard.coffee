# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.uf-select').change ->
  uf_id = $(this).val()
  id = $(this).data('indice')
  preencherCidades(id, uf_id);
  $("#estado-value-select-"+id).val(uf_id)


$('.pais-select').change ->
  pais_id = $(this).val()
  id = $(this).data('indice')
  preencherEstados(id,  pais_id, 0, 0);
  $("#pais-value-select-"+id).val(pais_id)

$('.cidade-select').change ->
  cidade_id = $(this).val()
  id = $(this).data('indice')
  preencherBairros(id,  cidade_id, 0);
  $("#cidade-value-select-"+id).val(cidade_id)




