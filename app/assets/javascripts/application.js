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
        }
        else{
          $("#"+blogID).html("Archive");
          $(".archive_button").show();

          // $("#"+blogID, ".edit_button").hide();

        }
      }
    });
  });

  //select2
  $(".js-example-basic-multiple").select2({
    placeholder: "Choose category",
    allowClear: true
  });

  // convert image to base 64
  $('#image_upload').change(function(data) {
    setTimeout(function(){
      var fileUpload = new FileReader;
      var file = document.getElementById("image_upload").files[0];
      var image = new Image();
      setTimeout(function(){
        fileUpload.onload = function (e){
        return function (e){
         image.src = e.target.result
         if(image.width < 400 || image.height < 160){
            var error_message = "Upload a photo with a 535x350 or bigger dimension.";
            $('.message').html(error_message);
            showErrorPopOut();  
            console.log("if");
          }
          else{
            $('#image_base64_holder').attr("value",e.target.result);
            $(".image_holder").css("background-image", "url("+image.src+")");
          }
        }
      }(file);
      fileUpload.readAsDataURL(file);
      });
    });
  });

});
