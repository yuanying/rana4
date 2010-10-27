$(function() {
  var setupHtmlArea = function() {
    if ($('#entry_format_type').length == 0) {
      return;
    };
    var bodyHtmlArea = null;
    var extendHtmlArea = null;
    var enableHtmlArea = function() {
      bodyHtmlArea = $('#body_text textarea').htmlarea()[0].jhtmlareaObject;
      bodyHtmlArea.p();
      extendHtmlArea = $('#extend_text textarea').htmlarea()[0].jhtmlareaObject;
      extendHtmlArea.p();
      $('.jHtmlArea').css('width', '100%'); // Require for outer frame's width
      $('.jHtmlArea .ToolBar').css('width', '100%'); // Require for outer frame's width
      $('.jHtmlArea').find('iframe').css('width', '98%'); // Should allow for padding based on CSS rules
      $('.jHtmlArea').find('iframe').css('height', '20em'); // Required for inner iframe's height
    };
    var disableHtmlArea = function() {
      if (bodyHtmlArea) {
        bodyHtmlArea.updateTextArea();
        bodyHtmlArea.dispose();
      }
      if(extendHtmlArea) {
        extendHtmlArea.updateTextArea();
        extendHtmlArea.dispose();
      }
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
    $(window).bind('unload', function() {
      if (bodyHtmlArea == null || extendHtmlArea == null ) { return; }
      bodyHtmlArea.toggleHTMLView();
      extendHtmlArea.toggleHTMLView();
    });
  };
  
  var setupTabs = function() {
    $(".tabs").tabs();
  };
  
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
  };
  
  var setupUploadAttachmentButton = function() {
    $('#upload_attachment_button').bind('click', function() {
      $('#upload_dialog').load(Rana.new_attachment_path + " #new_attachment_form_div");
      $('#upload_dialog').dialog({
        title : 'Select Image.',
        modal : true,
        width : '80%',
        dummy : null
      });
      return false;
    });
  };
  
  var setupUploadDialogWaitImage = function() {
    $('#new_attachment_form_div form').live('submit', function(){
      $('input[type=submit]', this).attr('disabled', 'disabled');
      $('#new_file_attachment_div').css('display', 'none');
      $('#new_file_attachment_div').after($('<p><img src="' + Rana.waiting_image_path + '" width="128" height="15" alt="Waitting..." /></p>'));
    });
  };
  
  var setupIdentifyString = function() {
    if ($('#entry_identify_string').val().length == 0) {
      $('#entry_identify_string').val($('#entry_identify_string_temp').val());
    }
  };
  
  // var setupDescriptionAutoCreate = function() {
  //   if ($('#entry_description').length == 0) {
  //     return;
  //   }
  //   var suggestDescription = $('#entry_description').val();
  //   $('#entry_body_text').bind('change', function() {
  //     var text = $('#entry_body_text').val();
  //     var description = $('#entry_description').val();
  //     text = $($('#entry_body_text').val()).text();//.subString(0, 255);
  //     if (description == suggestDescription) {
  //       suggestDescription = text;
  //       $('#entry_description').val(suggestDescription);
  //     }
  //   });
  // }
  
  
  setupTabs();
  setupPathSuggestion();
  setupUploadAttachmentButton();
  setupUploadDialogWaitImage();
  setupIdentifyString()
  // setupDescriptionAutoCreate();
  // for safari bug?
  setTimeout(setupHtmlArea,500);
  // jQuery.event.add(window, "load", setupHtmlArea);
});