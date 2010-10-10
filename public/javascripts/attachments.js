$(function() {
  attachment_list_item = $('#attachment_list_item');
  if (attachment_list_item.length > 0) {
    attachment_list_item = parent.window.$(attachment_list_item.html());
    attachment_list_item.attr('class', 'new');
    parent.window.$('table.attachments tbody').append(attachment_list_item);
  } else {
    alert('Invalid Image.');
  }
  parent.window.$('#upload_dialog').dialog( "destroy" );
});