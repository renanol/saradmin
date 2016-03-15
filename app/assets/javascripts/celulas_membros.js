/**
 * Created by renanoliveira on 3/7/16.
 */

//= require beyond/toastr/toastr.min

$(function() {

  $('body').on("click", ".add_celula_membro", function(e) {
    e.preventDefault();

    var membro_id = $(this).data("membro-id"),
      celula_id = $(this).data("celula-id"),
      $el = $(this);

    $.post("/celulas/" + celula_id + "/membros", {
      membro_id: membro_id
    }).success(function(data) {
      $el.closest("tr").remove();
      $("#tbl-celula-membro >  tbody").append(drawRowRemove(data));

      Notify('Salvo com sucesso!', 'top-right', '5000', 'success', 'fa-check', true);

    });

  });

  $('body').on("click", ".remove_celula_membro", function(e) {
    e.preventDefault();

    var celula_membro_id = $(this).data("celula-membro-id"),
      celula_id = $(this).data("celula-id"),
      $el = $(this);

    $.ajax({
      url: "/celulas/" + celula_id + "/membros",
      method: 'delete',
      data: {
        celula_membro_id: celula_membro_id
      }
    }).success(function(data) {
      $el.closest("tr").remove();
      Notify('Removido com sucesso!', 'top-right', '5000', 'danger', 'fa-remove', true);
    });

  });

  $('body').on("click", "#search", function(e) {

    e.preventDefault();

    var nome = $("#nome").val(),
      igreja_id = $("#igreja-id").val(),
      celula_id = $("#celula-id").val(),

      $el = $(this);

    $.ajax({
      url: "/celulas/" + celula_id + "/membros/search",
      method: 'get',
      data: {
        nome: nome,
        igreja_id: igreja_id,

      }
    }).success(function(data) {
      $("#tbl-membro > tbody").empty();
      $.each(data, function() {
        $("#tbl-membro > tbody").append(drawRowAdd({
          membro: {
            nome: this.nome,
            id: this.id
          },
          celula: {
            id: $("#celula-id").val()
          },

        }));
      })

    });

  });

});

function drawRowAdd(data) {
  var row = $("<tr />");
  row.append("<td>" + data.membro.nome + "</td>");
  row.append("<td><a href='#' class='add_celula_membro btn btn-default btn-xs icon-only success' data-membro-id='" + data.membro.id + "' data-celula-id='" + data.celula.id + "'><i class='fa fa-plus'></i></a> </td>");
  return row;
}

function drawRowRemove(data) {
  var row = $("<tr />");
  row.append("<td>" + data.membro.nome + "</td>");
  row.append("<td><a href='#' class='remove_celula_membro btn btn-default btn-xs icon-only danger' data-membro-id='" + data.membro.id + "' data-celula-membro-id='" + data.id + "' data-celula-id='" + data.celula.id + "'><i class='fa fa-remove'></i></a> </td>");
  return row;
}
