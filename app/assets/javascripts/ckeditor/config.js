let full = [
  { name: 'document', items: [ 'Source', '-', 'Save', 'NewPage', 'Preview', 'Print', '-', 'Templates' ] },
  { name: 'clipboard', items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
  { name: 'editing', items: [ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
  { name: 'forms', items: [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] },
  '/',
  { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'CopyFormatting', 'RemoveFormat' ] },
  { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl', 'Language' ] },
  { name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
  { name: 'insert', items: ['Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak', 'Iframe' ] },
  '/',
  { name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
  { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
  { name: 'tools', items: [ 'Maximize', 'ShowBlocks' ] },
  { name: 'about', items: [ 'About' ] }
];

let mini = [
  { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-'] },
  { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Blockquote'] },
  { name: 'links', items: [ 'Link'] },
];

CKEDITOR.editorConfig = function(config) {
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures?";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures?";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures?";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";
  config.uiColor = '#eeeeee';
  config.toolbar = full;
  config.toolbar_mini = mini;
}
