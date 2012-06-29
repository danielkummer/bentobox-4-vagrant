class Bentobox
  include Mongoid::Document
  belongs_to :user
  belongs_to :vagrantbox
  has_and_belongs_to_many :ingredients #, inverse_of: nil

  field :name
  field :description
  field :public, type: Boolean

  attr_accessible :ingredients,
                  :name,
                  :description,
                  :public,
                  :vagrantbox

  validates :name, presence: true
  validate :has_vagrantbox?

  def has_vagrantbox?
    errors.add(:vagrantbox_id, "Bento must have a vagrantbox") if self.vagrantbox.blank?
  end


end
