# Use this hook to configure ckeditor
if Object.const_defined?("Ckeditor")
  Ckeditor.setup do |config|
    # ==> ORM configuration
    # Load and configure the ORM. Supports :active_record (default), :mongo_mapper and
    # :mongoid (bson_ext recommended) by default. Other ORMs may be
    # available as additional gems.
    require "ckeditor/orm/active_record"

    # Allowed image file types for upload.
    # Set to nil or [] (empty array) for all file types
    # config.image_file_types = ["jpg", "jpeg", "png", "gif", "tiff"]

    # Allowed attachment file types for upload.
    # Set to nil or [] (empty array) for all file types
    # config.attachment_file_types = ["doc", "docx", "xls", "odt", "ods", "pdf", "rar", "zip", "tar", "swf"]

    # Setup authorization to be run as a before filter
    # config.authorize_with :cancan
  end

  # config.toolbar_MyToolbar = [
  #   { name: 'document', items: [ 'NewPage','Preview' ] },
  #   { name: 'clipboard', items: [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
  #   { name: 'editing', items: [ 'Find','Replace','-','SelectAll','-','Scayt' ] },
  #   { name: 'insert', items: [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] },
  #   { name: 'styles', items: [ 'Styles','Format' ] },
  #   { name: 'basicstyles', items: [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
  #   { name: 'paragraph', items: [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote' ] },
  #   { name: 'links', items: [ 'Link','Unlink','Anchor' ] },
  #   { name: 'tools', items: [ 'Maximize','-','About' ] }
  # ];
end
