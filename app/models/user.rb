# frozen_string_literal: true

class User < ApplicationRecord
  validates :fname, :lname, :email, presence: true
  has_many :items, dependent: :restrict_with_exception
  has_many :categories, dependent: :restrict_with_exception
  has_many :orders, dependent: :restrict_with_exception
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { standard: 0, admin: 1 }
end
