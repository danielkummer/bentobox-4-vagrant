class Bentobox
  include Mongoid::Document
  belongs_to :user
  has_and_belongs_to_many :ingredients #, inverse_of: nil
  belongs_to :vagrantbox

  field :name
  field :description
  field :public, type: Boolean

  attr_accessible :ingredient_ids,
                  :name,
                  :description,
                  :public,
                  :vagrantbox

  validates :name, presence: true
  validate :has_vagrantbox?, :has_ingredients?

  def has_vagrantbox?
    errors.add(:vagrantbox_id, "Bento must have a vagrantbox") if self.vagrantbox.blank?
  end


end
