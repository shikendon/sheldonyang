class User < ActiveRecord::Base
  extend OmniauthCallbacks

  has_many :authorizations
  has_many :examples

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  devise :database_authenticatable, :trackable, :omniauthable
end
