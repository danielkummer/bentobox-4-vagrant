class User
  include Mongoid::Document
  include DeviseExt

  validates :email, uniqueness: {case_sensitive: false}
  validates :email, format: {with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                             message: "Invalid email"}

  #validates :password, :length => 6..128 #should be handled by devise config - check!!

  has_many :bentoboxes
end
