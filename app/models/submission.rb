class Submission
  include Mongoid::Document
  
  field :post_id, type: String
  field :link, type: String
  field :link_title, type: String
  field :created, type: Time
  field :message, type: String
  field :likes, type: Array
  field :comments, type: Array
  
  belongs_to :user
  
  index :post_id, unique: true
  
  # Score of every document.
  #
  # Hackernew style - www.seomoz.org/blog/reddit-stumbleupon-delicious-and-hacker-news-algorithms-exposed
  def score
    (self[:likes].length*10 + self[:comments].length*10 )*100000/ (Time.now - self[:created])
  end
  
  # Comparator to compare by the hotness algorithm
  #
  # Standard comparator return
  def <=>(another)
     another.score <=> self.score
  end 
    
    
  # Returns only youtube entries in that list
  #
  def self.youtube_filter (submissions)
    youtube_submissions = submissions.map do |entry|
      if not entry[:link].nil? and not entry[:link].index("youtube").nil?
        entry
      else
        nil
      end
    end
    
    youtube_submissions.compact
  end
    
  # Calculates the hotness of each post and sorts them
  #
  # Returns top hot posts.
  def self.hot
    hot_entries =Submission.all(sort: [[ :created, :desc ]]).limit(50).to_a.sort
    Submission.youtube_filter hot_entries
  end
  
  def youtube_key
    return (/.*v=([^&.]*)/.match self[:link])[1]
  end
  
  def likers
    liker_users = []
    self[:likes].each do |like|
      liker_users.push User.find_or_create_by_fbid(like)
    end
    return liker_users
  end
  
  def commenters
    commenter_users = []
    self[:comments].each do |comment|
      commenter_users.push User.find_or_create_by_fbid(comment)
    end

    return commenter_users
  end
  
  def participants
    (commenters + likers).uniq
  end

end

module Enumerable
  def dups
    inject({}) {|h,v| h[v]=h[v].to_i+1; h}.reject{|k,v| v==1}.keys
  end
end 
