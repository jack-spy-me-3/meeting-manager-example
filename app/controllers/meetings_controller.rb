class MeetingsController < ApplicationController
  def index
    render 'index.html.erb'
  end

  def show
    @meeting = Meeting.find_by(id: params[:id])
    render 'show.html.erb'
  end
  
end
