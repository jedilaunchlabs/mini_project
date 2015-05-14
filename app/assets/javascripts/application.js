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

  $("body").on("click", ".archive_button", function(){
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


  $("body").on("click", ".live_button", function(){
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
        if(data.is_draft == false){
          $("#edit"+blogID).parent().parent().remove();
          $("#"+blogID).removeClass("live_button").addClass("archive_button").html("Archive");
        }
      }
    });
  });

  //select2
  $(".js-example-basic-multiple").select2({
    placeholder: "Choose category",
    allowClear: true
  });

  $("#buttonUploader").bind("click", function () {
    $("#imageUploader").trigger("click");
  });

  $('#imageUploader').change(function(data) {
    setTimeout(function(){
      var fileUpload = new FileReader;
      var file = document.getElementById("imageUploader").files[0];
      var image = new Image();
      setTimeout(function(){
        fileUpload.onload = function (e){
        return function (e){
          image.src = e.target.result
          $("#base64Image").val(e.target.result);
          $("#displayImage").css("background-image", "url(" + image.src + ")");
        }
      }(file);
      fileUpload.readAsDataURL(file);
      });
    });
  });

});
