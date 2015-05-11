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
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require select2

$(document).ready(function(){

  $(".archive_button").click(function(){
    var blogID = $(this).attr("id");
    $.ajax({      
      url:"/ajax/blogs/" + blogID + "/archive",
      type: "PUT",
      dataType:'json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        
      },
      error:function(data){ 
          
      },
      success:function(data){
        if(data.is_archived == true){
          $("#"+blogID).html("Archived");
        }
        else{
          $("#"+blogID).html("Archive");
        }
      }
    });
  });


  $(".live_button").click(function(){
    var blogID = $(this).attr("id");
    $.ajax({      
      url:"/ajax/blogs/" + blogID + "/live",
      type: "PUT",
      dataType:'json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        
      },
      error:function(data){ 
          
      },
      success:function(data){
        if(data.is_draft == true){
          $("#"+blogID).html("Live");
          $(".archive_button").show();
        }
        else{
          $("#"+blogID).hide();
          $(".edit_button").hide();
        }
      }
    });
  });

  $(".js-example-basic-multiple").select2({
    placeholder: "Choose a category"
  });

});
