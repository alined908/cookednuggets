# frozen_string_literal: true

# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default), :mongo_mapper and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'ckeditor/orm/active_record'
  config.cdn_url = "//cdn.ckeditor.com/4.12.1/full/ckeditor.js"
  config.image_file_types = %w(jpg jpeg png gif tiff)
  # config.attachment_file_types = %w(doc docx xls odt ods pdf rar zip tar tar.gz swf)
  # config.authorize_with :cancancan

  # Override parent controller CKEditor inherits from
  # By default: 'ApplicationController'
  # config.parent_controller = 'MyController'

  # Asset model classes
  # config.picture_model { Ckeditor::Picture }
  # config.attachment_file_model { Ckeditor::AttachmentFile }

  # Paginate assets
  # By default: 24
  # config.default_per_page = 24

  # Customize ckeditor assets path
  # By default: nil
  # config.asset_path = 'http://www.example.com/assets/ckeditor/'

  # config.js_config_url = 'ckeditor/config.js'
end
