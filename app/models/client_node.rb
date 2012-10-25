class ClientNode
  include ActiveModel::Validations
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :bentobox

  field :name, type: String

  validates :name, presence: true
  validates :bentobox, presence: true


  attr_accessible :name, :bentobox, :user
end
