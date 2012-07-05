class ShareFolder
  include Mongoid::Document
  field :logical_name, type: String
  field :host_path, type: String
  field :guest_path, type: String
  field :additional_options, type: String

  embedded_in :ingredient, :inverse_of => :share_folders

  validates :host_path, :guest_path, presence: true
  validates :logical_name, presence: true, uniqueness: true

  attr_accessible :logical_name, :host_path, :guest_path, :additional_options
end
