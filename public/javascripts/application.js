$(function() {
  var setupHtmlArea = function() {
    if ($('#entry_format_type').length == 0) {
      return;
    }
    if ($('#entry_format_type').val() == 'xhtml') {
      $('#body_text textarea').htmlarea();
      $('#extend_text textarea').htmlarea();
    }

    $('#entry_format_type').bind('change', function() {
      if ($(this).val() == 'xhtml') {
        $('#body_text textarea').htmlarea();
        $('#extend_text textarea').htmlarea();
      } else {
        $('#body_text textarea').htmlarea('dispose');
        $('#extend_text textarea').htmlarea('dispose');
      }
    });
  }
  
  var setupTabs = function() {
    $(".tabs").tabs();
  }
  
  var setupPathSuggestion = function() {
    if ($('#entry_path_suggestion').length == 0) {
      return;
    }
    var suggestValue = $('#entry_path_suggestion').val();
    $('#entry_title').bind('change', function() {
      var title = $('#entry_title').val();
      var path  = $('#entry_path_suggestion').val();
      title = title.replace(/[^a-zA-Z\-_]/g, '');
      if (title.length > 0 && path == suggestValue) {
        path = path.split('/');
        path.pop();
        path.push(title);
        path = path.join('/');
        suggestValue = path;
        $('#entry_path_suggestion').val(suggestValue);
      }
    });
  }
  
  setupHtmlArea();
  setupTabs();
  setupPathSuggestion();
});