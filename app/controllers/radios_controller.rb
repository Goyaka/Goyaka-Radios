class RadiosController < ApplicationController

  def index
    @submissions = Submission.hot
  end
  
  def new
    submissions  = Submission.all(sort: [[ :created, :desc ]]).limit(20)
    @submissions = Submission.youtube_filter submissions
  end
end