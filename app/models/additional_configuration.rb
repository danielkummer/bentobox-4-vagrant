class AdditionalConfiguration
  include Mongoid::Document
  field :name, type: String
  field :value, type: String

  has_and_belongs_to_many :bentoboxes, inverse_of: :additional_configurations, dependent: :restrict

  validates :value, :name, presence: true
  validates :value,
            format: {with: /^config\..+$/,
                     message: "Wrong format, please use 'config.'"}

  attr_accessible :name, :value

end
