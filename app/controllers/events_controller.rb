class EventsController < ApplicationController

  get '/events' do
    redirect_if_not_logged_in
    @user = current_user
    @events = User.events
    erb :'events/events'
  end

  get '/events/new' do
    redirect_if_not_logged_in
    @user = current_user
    erb :'events/new'
  end

  get '/events/:id' do
    redirect_if_not_logged_in
    @event = Event.find_by_id(params[:id])
    erb :'events/show'
  end

  post '/events/new' do
    redirect_if_not_logged_in
    if params[:name] != "" && params[:date] != ""
      @user = current_user
      @event = Event.create(name: params[:name], date: params[:date])
      @user.events << @event
      redirect to "/events/#{@event.id}"
    else
      redirect to '/events/new'
    end
  end

end
