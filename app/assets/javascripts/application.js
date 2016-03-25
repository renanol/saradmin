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
//= require beyond/bootbox/bootbox.min
//= require beyond/validation/bootstrapValidator.min
//= require dashboard

$(function(){

    $(".modal-endereco").on('click', function (e) {

        e.preventDefault();

        var indice = $(this).data("indice"),
            cidade_id = $("#cidade-"+indice).val(),
            estado_id = $("#uf-"+indice).val(),
            pais_id = $("#pais-"+indice).val(),
            title = $(this).data("title"),
            tipo = $(this).data("tipo");

        bootbox.prompt("Cadastrar "+title, function (result) {

            if (result === "") {
                bootbox.alert("Campo não pode ser vazio");
            } else if (result !== null){

                if(tipo === "bairro") {

                    validaNovoEndereco("cidade-"+indice, "uma cidade");

                    $.ajax({
                        url: "/enderecos/bairros",
                        type: "POST",
                        dataType: 'json',
                        data: {
                            nome: result,
                            cidade_id: cidade_id
                        },
                        success: function (data) {

                            $("#bairro-value-select-"+indice).val(data.id)
                            preencherBairros(indice, $("#cidade-"+indice).val());


                        }, error: function (data) {
                            bootbox.alert("<h1>" + data.responseJSON.nome[0] + "</h1>")
                        }
                    });
                }else if(tipo == "cidade"){
                    validaNovoEndereco("estado-"+indice, "um estado");
                    $.ajax({
                        url: "/enderecos/cidades",
                        type: "POST",
                        dataType: 'json',
                        data: {
                            nome: result,
                            estado_id: estado_id
                        },
                        success: function (data) {

                            $("#cidade-value-select-"+indice).val(data.id)
                            preencherCidades(indice, estado_id,  data.id);

                        }, error: function (data) {
                            bootbox.alert("<h1>" + data.responseJSON.nome[0] + "</h1>")
                        }
                    });
                }else if(tipo == "estado"){
                    validaNovoEndereco("pais-"+indice, "um pais");
                    $.ajax({
                        url: "/enderecos/estados",
                        type: "POST",
                        dataType: 'json',
                        data: {
                            nome: result,
                            pais_id: pais_id
                        },
                        success: function (data) {
                            $("#estado-value-select-"+indice).val(data.id);
                            preencherEstados(indice,  pais_id, data.id, 0);
                        }, error: function (data) {
                            bootbox.alert("<h1>" + data.responseJSON.nome[0] + "</h1>")
                        }
                    });
                }else if(tipo == "pais"){

                    $.ajax({
                        url: "/enderecos/paises",
                        type: "POST",
                        dataType: 'json',
                        data: {
                            nome: result
                        },
                        success: function (data) {
                            $("#pais-value-select-"+indice).val(data.id)
                            preencherPaises(indice, data.id, 0, 0);
                        }, error: function (data) {
                            bootbox.alert("<h1>" + data.responseJSON.nome[0] + "</h1>")
                        }
                    });
                }

            }
        });
    });

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

        $.ajax({
            type: method,
            url: url,
            data: dados,
            dataType: "JSON"
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


    preencherPaises(0, $("#pais-value-select-0").val(), $("#estado-value-select-0").val(), $("#cidade-value-select-0").val());
    preencherPaises(1, $("#pais-value-select-1").val(), $("#estado-value-select-1").val(), $("#cidade-value-select-1").val());

});

function validaNovoEndereco(id, descricao){
    if($("#"+id).val() == null || $("#"+id).val() == 0){
        bootbox.alert("Selecione "+ descricao);
        return;
    }
}

function buscarBairro(bairro_id){
    $.ajax({
        url: '/enderecos/bairro',
        data: {
            bairro_id: bairro_id
        },
        type: 'GET',
        success: function(data){

            console.log(data)

        }
    });
}

function preencherPaises(indice, valor, estado_id, cidade_id){

    $.ajax({
        url: '/enderecos/buscar_paises',
        type: 'GET',
        beforeSend: function(){

        },
        success: function(data){
            var options = $("#pais-"+indice);
            options.empty();

            options.append($("<option />").val(0).text("Selecione"));
            $.each(data, function() {
                options.append($("<option />").val(this.id).text(this.nome));
            });
            $("#pais-"+indice).val(valor);

            preencherEstados(indice, valor, estado_id, cidade_id);

        }
    });
}

function preencherEstados(indice, valor, estado_id, cidade_id){

    $.ajax({
        url: '/enderecos/buscar_estados',
        data: {
            pais_id: valor
        },
        type: 'GET',
        beforeSend: function(){

        },
        success: function(data){
            var options = $("#uf-"+indice);
            options.empty();

            options.append($("<option />").val(0).text("Selecione"));

            $.each(data, function() {
                options.append($("<option />").val(this.id).text(this.nome));
            });

            $("#uf-"+indice).val(estado_id);
            preencherCidades(indice, estado_id, cidade_id);


        }
    });
}



function preencherCidades(indice, valor, cidade_id){
    $.ajax({
        url: '/enderecos/buscar_cidades',
        data: {
            estado_id: valor
        },
        type: 'GET',
        beforeSend: function(){

        },
        success: function(data){
            var options = $("#cidade-"+indice);
            options.empty();

            options.append($("<option />").val(0).text("Selecione"));
            $.each(data, function() {
                options.append($("<option />").val(this.id).text(this.nome));
            });



            $("#cidade-"+indice).val(cidade_id);

            preencherBairros(indice, cidade_id);

        }
    });
}

function preencherBairros(indice, valor){

    $.ajax({
        url: '/enderecos/buscar_bairros',
        data: {
            cidade_id: valor
        },
        type: 'GET',
        beforeSend: function(){

        },
        success: function(data){
            var options = $("#bairro-"+indice);
            options.empty();

            options.append($("<option />").val(0).text("Selecione"));
            $.each(data, function() {
                options.append($("<option />").val(this.id).text(this.nome));
            });

            $("#bairro-"+indice).val($("#bairro-value-select-"+indice).val());
        }
    });
}

