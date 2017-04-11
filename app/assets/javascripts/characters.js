//turn to inline mode
$.fn.editable.defaults.mode = 'inline';
$.fn.editable.defaults.ajaxOptions = {type: "PUT"};

$(document).ready(function() {

    $('#character_table a[data-type="text"]').editable({
      params: function(params) {
        //originally params contain pk, name and value
        params.character = {};
        params.character[params["name"]] = params["value"]
        return params;
      }
    });

});
