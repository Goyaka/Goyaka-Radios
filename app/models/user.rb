class User
  include Mongoid::Document
  
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
end