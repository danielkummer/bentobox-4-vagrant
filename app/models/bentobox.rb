class Bentobox
  include ActiveModel::Validations
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :owners, inverse_of: :owner_of, class_name: "User"

  belongs_to :vagrantbox
  has_many :client_nodes
  has_and_belongs_to_many :ingredients, :inverse_of => :bentoboxes
  has_and_belongs_to_many :additional_configurations, :inverse_of => :bentoboxes, dependent: :restrict

  #problems with point in name - generate slug later...
  #field :_id, type: String, default: -> { name }
  field :name, type: String
  field :description, type: String
  field :public, type: Boolean, default: true

  validates :name, presence: true
  validates :vagrantbox, presence: true
  validates :owner_ids , presence: true


  attr_accessible :name, :description, :public, :vagrantbox, :ingredient_ids, :additional_configuration_ids, :owner_ids

  scope :visible_to_user, ->(user = nil) {
    if user.present?
      any_of({public: true}, {user_id: user.id})
    else
      where(public: true)
    end
  }

  scope :recent, ->(limit) { desc(:created_at).limit(limit) }

  def add_client_node_for(user, node_name)
    client_nodes.create!(name: node_name, user: user, bentobox: self)
  end

end
