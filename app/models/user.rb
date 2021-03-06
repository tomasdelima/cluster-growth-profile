class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  validates :name, :email, presence: true, uniqueness: true

  has_and_belongs_to_many :clusters
end
