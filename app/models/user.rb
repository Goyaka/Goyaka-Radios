class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :trackable, :omniauthable, :timeoutable

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
  field :credentials,        :type => Hash
  
  # Facebook id
  field :fbid, type: String
  field :name, type: String
  
  index :fbid, unique: true
  
  
  def self.find_or_create_by_fbid(fbid, name = '')
    if User.where(:fbid => fbid).first.nil?
      u = User.create(:fbid => fbid, :name => name)
      u.save!
    else
      u = User.where(:fbid => fbid).first
    end
    
    return u
  end

  def self.find_or_create_from_omniauth(data)
    user = User.find_or_create_by_fbid(data['uid'], data['info']['name'])
    if user.credentials.nil? 
      user.credentials = data['credentials']
      user.update_profile data['raw_info']
      user.save!
    end
    
    return user
  end
  
  def update_profile(raw_info)
    
  end
end