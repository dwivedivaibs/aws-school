if (typeof(CKEDITOR) != 'undefined') {
  CKEDITOR.editorConfig = function( config )
    { 
      config.enterMode = CKEDITOR.ENTER_BR;
      config.shiftEnterMode = CKEDITOR.ENTER_BR;
      config.autoParagraph = false;
    }
}