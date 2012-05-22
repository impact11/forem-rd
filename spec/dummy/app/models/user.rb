class User
  include Mongoid::Document
  include Forem::DefaultPermissions
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable

  field :login
  field :email
  field :forem_admin, type: Boolean, default: false

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def to_s
    login
  end

  def email=(address)
    self.update_attribute(:email, address)
  end

  def encrypted_password=(password)
    self.update_attribute(:encrypted_password, password)  
  end
end
