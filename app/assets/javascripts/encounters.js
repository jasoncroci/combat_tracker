//turn to inline mode
$.fn.editable.defaults.mode = 'inline';
$.fn.editable.defaults.ajaxOptions = {type: "PUT"};

$(document).ready(function() {

    $('a[data-type="text"]').editable({
      // success: function(response, newValue) {
      //   console.log('SUCXCCC')
      //   console.log(response);
      //   console.log(newValue);
      // },
      params: function(params) {
        //originally params contain pk, name and value
        params.enemy = {};
        params.enemy[params["name"]] = params["value"]
        return params;
      }
    });


});
