//= require nested_form_fields

//turn to inline mode
$.fn.editable.defaults.mode = 'inline';
$.fn.editable.defaults.ajaxOptions = {type: "PUT"};

$(document).ready(function() {

    $('#enemy_table a[data-type="text"]').editable({
      params: function(params) {
        //originally params contain pk, name and value
        params.enemy = {};
        params.enemy[params["name"]] = params["value"]
        return params;
      }
    });

    setupNestedFields = function(){
      $("fieldset.nested_fields").each(function(i, item){
        if($(this).find("input").val() != ""){
          $(this).hide();
        }
      });
      $(".hidden").removeClass("hidden")
    }

    setupNestedFields();
});
