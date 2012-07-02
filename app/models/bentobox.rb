class Bentobox
  include ActiveModel::Validations
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :vagrantbox
  has_and_belongs_to_many :ingredients, :inverse_of => :bentoboxes

  field :name
  field :description
  field :public, type: Boolean

  validates :name, presence: true
  #validate :has_vagrantbox?
  validates :vagrantbox, :has_one => true

=begin
  def has_vagrantbox?
    errors.add(:vagrantbox_id, "Bento must have a vagrantbox") if self.vagrantbox.blank?
  end
=end

end
