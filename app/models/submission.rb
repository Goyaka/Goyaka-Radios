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
    (self[:likes].length + self[:comments].length)/ (Time.now - self[:created])
  end
  
  # Comparator to compare by the hotness algorithm
  #
  # Standard comparator return
  def <=>(another)
     another.score <=> self.score
  end 
    
  # Calculates the hotness of each post and sorts them
  #
  # Returns top hot posts.
  def self.hot
    Submission.limit(50).to_a.sort
  end
  
  
end