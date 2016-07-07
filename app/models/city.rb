class City < ActiveRecord::Base
  belongs_to :cluster

  validates :name, presence: true, uniqueness: true
end
