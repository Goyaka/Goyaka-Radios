class RadiosController < ApplicationController

  def index
    @submissions = Submission.hot
  end
  
  def new
    submissions  = Submission.all(sort: [[ :created, :desc ]]).limit(20)
    @submissions = Submission.youtube_filter submissions
  end
  
  def like
    submission = Submission.where(:post_id => params[:post_id]).first
    submission.like.push current_user
  end
end