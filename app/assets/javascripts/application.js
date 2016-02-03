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

    $(".btn-search").on("click", function(){
        $('form').get(0).setAttribute('action', $(this).data('action'));
        $('form').get(0).removeAttribute('target');
        $(this).closest("form").submit();
    });

    $(".btn-report").on("click", function(){
        $('form').get(0).setAttribute('action', $(this).data('action'));
        $('form').get(0).setAttribute('target', '_blank');
        $(this).closest("form").submit();
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

});