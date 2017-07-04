class User < ApplicationRecord
#  
after_create :assign_default_role

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable,
         :omniauth_providers => [:facebook]
  has_many :teams

  def fullname
    fullname = ''
    fullname << first_name if ! first_name.blank?
    fullname << ' ' << last_name  if ! last_name.blank?
    fullname = email if fullname.blank?
    return fullname
  end


  def self.from_omniauth(auth)
  	where(provider: auth[:provider],uid:auth[:uid]).first_or_create do |user|
  		if auth[:info]
  		  user.email=auth[:info][:email]
  		  user.name=auth[:info][:name]
  		end
  		user.password = Devise.friendly_token[0,20]
  	end	
  end
  def assign_default_role
    self.add_role(:registrado) if self.roles.blank?
  end

end
