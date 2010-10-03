$(function() {
  var setupHtmlArea = function() {
    if ($('#entry_format_type').length == 0) {
      return;
    };
    var enableHtmlArea = function() {
      $('#body_text textarea').htmlarea();
      $('#extend_text textarea').htmlarea();
      $('.jHtmlArea').css('width', '100%'); // Require for outer frame's width
      $('.jHtmlArea .ToolBar').css('width', '100%'); // Require for outer frame's width
      $('.jHtmlArea').find('iframe').css('width', '98%'); // Should allow for padding based on CSS rules
      $('.jHtmlArea').find('iframe').css('height', '20em'); // Required for inner iframe's height
    };
    var disableHtmlArea = function() {
      $('#body_text textarea').htmlarea('updateTextArea');
      $('#body_text textarea').htmlarea('dispose');
      $('#extend_text textarea').htmlarea('updateTextArea');
      $('#extend_text textarea').htmlarea('dispose');
    };
    
    if ($('#entry_format_type').val() == 'xhtml') {
      enableHtmlArea();
    }

    $('#entry_format_type').bind('change', function() {
      if ($(this).val() == 'xhtml') {
        enableHtmlArea();
      } else {
        disableHtmlArea();
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
  
  
  setupTabs();
  setupPathSuggestion();
  // for safari bug?
  setTimeout(setupHtmlArea,500);
});