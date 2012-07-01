class ShareFolder
  include Mongoid::Document
  field :logical_name, type: String
  field :host_path, type: String
  field :guest_path, type: String
  field :additional_options, type: String
  embedded_in :ingredient, :inverse_of => :share_folders
end
