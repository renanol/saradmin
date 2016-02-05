// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require beyond/bootstrap.min
//= require bootstrap-datepicker.min
//= require bootstrap-datepicker.pt-BR
//= require beyond/slimscroll/jquery.slimscroll.min
//= require beyond/skins.min
//= require beyond/beyond.min
//= require turbolinks
//= require nested_form_fields
//= require jquery.maskMoney.min
//= require jquery.maskedinput.min
//= require_tree .

$(function(){

    $("#cadastrar_igreja").on("click", function(){
        $(".modal-alterar-grupo").modal()
    });

    if(window.location.pathname === "/"){
        localStorage.setItem('link_menu', '/');
    }

    $("#submeter").on("click", function(){

        var dados = $("form").serialize(),
            url = $("form").attr("action"),
            method = $("form").attr("method");
        console.log(url)
        $.ajax({
            type: method,
            url: url,
            data: dados,
            dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
        }).success(function(json){
            console.log("success", json);
        });
    })

    $(".open-menu").click(function(){
        localStorage.setItem('link_menu', $(this).attr('href'));
    });


    $('.nav a').each(function(index) {

        if($(this).attr("href") == localStorage.getItem("link_menu")){
          $(this).parent("li").addClass("active").parents("li").addClass("active open");
        }

    });

    $(".formatarMoeda").maskMoney({thousands:'.', decimal:',',  allowZero:true });

    $( '.date-picker' ).datepicker({
        autoclose:true,
        language: 'pt-BR'

    });

    $(".date-picker").mask("99/99/9999");

    $(".formatar-cpf").mask("999.999.999-99");

    preencherCidades(0);
    preencherBairros(0);
    preencherCidades(1);
    preencherBairros(1);


});

function preencherCidades(indice){


    $("#uf-"+indice).val($("#estado-value-select-"+indice).val());

    $.ajax({
        url: '/igrejas/buscar_cidades',
        data: {
            estado_id: $("#estado-value-select-"+indice).val()
        },
        type: 'GET',
        beforeSend: function(){

        },
        success: function(data){
            var options = $("#cidade-"+indice);
            options.empty();
            $.each(data, function() {
                options.append($("<option />").val(this.id).text(this.nome));
            });
            $("#cidade-"+indice).val($("#cidade-value-select-"+indice).val());

        }
    });
}

function preencherBairros(indice){

    $.ajax({
        url: '/igrejas/buscar_bairros',
        data: {
            cidade_id: $("#cidade-value-select-"+indice).val()
        },
        type: 'GET',
        beforeSend: function(){

        },
        success: function(data){
            var options = $("#bairro-"+indice);
            options.empty();
            $.each(data, function() {
                options.append($("<option />").val(this.id).text(this.nome));
            });

            $("#bairro-"+indice).val($("#bairro-value-select-"+indice).val());

        }
    });
}