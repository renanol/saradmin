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
//= require beyond/slimscroll/jquery.slimscroll.min
//= require beyond/skins.min
//= require beyond/beyond.min
//= require turbolinks
//= require nested_form_fields
//= require_tree .

$(function(){

    $("#cadastrar_igreja").on("click", function(){
        $(".modal-alterar-grupo").modal()
    });

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

});