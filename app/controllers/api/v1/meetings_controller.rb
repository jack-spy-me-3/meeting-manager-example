class Api::V1::MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
    render "index.json.jbuilder"
  end

  def show
    @meeting = Meeting.find_by(id: params[:id])
    render "show.json.jbuilder"
  end

  def create
    @meeting = Meeting.new(
      name: params[:name],
      address: params[:address],
      start_time: params[:start_time],
      end_time: params[:end_time],
      notes: params[:notes]
    )
    if @meeting.save
      # params[:tag_ids].each do |tag_id|
      #   MeetingTag.create(meeting_id: @meeting.id, tag_id: tag_id)
      # end
      flash[:success] = "Your meeting has been created!"
      render "show.json.jbuilder"
    else
      flash[:error] = "Your meeting has not been created!"
      render 'new.html.erb'
    end
  end

  def update
    @meeting = Meeting.find_by(id: params[:id])
    @meeting.assign_attributes(name: params[:name],
                               address: params[:address],
                               start_time: params[:start_time],
                               end_time: params[:end_time],
                               notes: params[:notes]
                              )
    if @meeting.save
      @meeting.tags.destroy_all
      params[:tag_ids].each do |tag_id|
        MeetingTag.create(meeting_id: @meeting.id, tag_id: tag_id)
      end
      flash[:success] = "Meeting has been updated"
      redirect_to "/meetings/#{@meeting.id}"
    else
      flash[:error] = "Meeting has not been updated. Please try again."
      render "edit.html.erb"
    end
  end
end
