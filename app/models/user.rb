class User < ApplicationRecord
  has_many :items
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:standard,:admin]
  after_initialize do
    if self.new_record?
      self.role ||= :standard
    end
  end
end
