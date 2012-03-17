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
    post = FbGraph::Post.new(params[:post_id])
    post.like!(:access_token => current_user[:credentials]['token'])
    submission.add_user_like current_user
    
    render :json => {'status' => 'OK'}
  end
end