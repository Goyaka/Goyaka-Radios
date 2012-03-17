class FacebookFetcher
  # Initializes Fetcher with group id.
  # 
  # group_id     - Integer of group's graph id
  # access_token - Access token
  # 
  # Returns FacebookFetcher
  def initialize (group_id, access_token)
    puts "Initializing facebook"
    @group = FbGraph::Group.fetch(group_id,:access_token => access_token)
  end
  
  # Accessor for group
  # 
  # Returns group
  def group
    @group
  end
  
  # Updates a submission with feed object. Creates users as well.
  #
  # Returns nothing.
  def update_submission(feed)
    if Submission.where(:post_id => feed.identifier).length > 0
      submission = Submission.where(:post_id => feed.identifier).first
    else
      submission = Submission.create(:post_id => feed.identifier)
    end
    
    user                    = User.find_or_create_by_fbid(feed.from.identifier, feed.from.name)
    submission.user         = user
    submission[:link]       = feed.link
    submission[:link_title] = feed.name
    submission[:created]    = feed.created_time

    
    submission[:message] = feed.message
    likes = []
    feed.likes.each do |liker|
      liker_user = User.find_or_create_by_fbid(liker.identifier, liker.name)
      likes.push liker_user[:fbid]
    end
    
    comments = []
    feed.comments.each do |comment|
      commenter = User.find_or_create_by_fbid(comment.from.identifier, comment.from.name)
      comments.push commenter[:fbid]
    end
    
    submission[:likes]    = likes.compact
    submission[:comments] = comments.compact
    submission.save!
  end
   
  # Updates the database from facebook feed.
  #
  # Returns nothing.
  def self.fetch_feeds
    fetcher = self.new(APP_CONFIG['group_id'], APP_CONFIG['access_token'])
    puts "Fetching feeds"
    feeds   = fetcher.group.feed(:limit => 20)
    feeds.each do |feed|
      puts "Updating (#{feed.message})"
      fetcher.update_submission(feed)
    end
    return feeds
  end

end