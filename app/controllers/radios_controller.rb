class RadiosController < ApplicationController

  def index
    @submissions = Submission.hot
  end
  
end