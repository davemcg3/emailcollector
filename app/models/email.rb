class Email < ActiveRecord::Base
  validates :email, presence: true
  validates_uniqueness_of :email, scope: [:source]
end
