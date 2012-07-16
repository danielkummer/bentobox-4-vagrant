class Bentobox
  include ActiveModel::Validations
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :vagrantbox
  has_and_belongs_to_many :ingredients, :inverse_of => :bentoboxes
  has_and_belongs_to_many :additional_configurations, :inverse_of => :bentoboxes, dependent: :restrict

  #problems with point in name - generate slug later...
  #field :_id, type: String, default: -> { name }
  field :name, type: String
  field :description, type: String
  field :public, type: Boolean, default: true

  validates :name, presence: true
  validates :vagrantbox, presence: true


  attr_accessible :name, :description, :public, :vagrantbox, :ingredient_ids

  scope :visible_to_user, ->(user = nil) {
    if user.present?
      any_of({public: true}, {user_id: user.id})
    else
      where(public: true)
    end
  }

  scope :recent, ->(limit) { desc(:created_at).limit(limit) }

end
