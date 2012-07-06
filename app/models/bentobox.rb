class Bentobox
  include ActiveModel::Validations
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :vagrantbox
  has_and_belongs_to_many :ingredients, :inverse_of => :bentoboxes

  #problems with point in name - generate slug later...
  #field :_id, type: String, default: -> { name }
  field :name
  field :description
  field :public, type: Boolean

  validates :name, presence: true
  validates :vagrantbox, presence: true

  attr_accessible :name, :description, :public, :vagrantbox, :ingredients

  scope :visible_to_user, lambda { |user|
    any_of({:public => true}, {:user_id => user.id})
  }

end
