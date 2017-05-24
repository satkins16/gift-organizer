class EventsController < ApplicationController

  get '/events' do
    redirect_if_not_logged_in
    @user = current_user
    @events = @user.events
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
    @gifts = @event.gifts
    erb :'events/show'
  end

  get '/events/:id/gifts/new' do
    redirect_if_not_logged_in
    @event = Event.find_by_id(params[:id])
    @givers = Giver.all
    erb :'gifts/new'
  end

  get '/events/:id/edit' do
    redirect_if_not_logged_in
    @event = Event.find_by_id(params[:id])
    erb :'events/edit'
  end

  get '/events/:id/gifts/:id2/edit' do
    redirect_if_not_logged_in
    @event = Event.find_by_id(params[:id])
    @gift = Gift.find_by_id(params[:id2])
    @givers = Giver.all
    erb :'gifts/edit'
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

  post '/events/:id/gifts/new' do
    redirect_if_not_logged_in
    @user = current_user
    @event = Event.find_by_id(params[:id])
    @gift = Gift.create(params[:gift])
    @event.gifts << @gift
    @user.gifts << @gift
    @gift.event = @event
    if !params[:giver][:name].empty?
      @giver = Giver.create(name: params[:giver][:name])
      @gift.givers << @giver
      @user.givers << @giver
    end
    @event.save
    @gift.save
    redirect to "/events/#{@event.id}"
  end

  post '/events/:id/edit' do
    redirect_if_not_logged_in
    @event = Event.find_by_id(params[:id])
    @event.name = params[:name]
    @event.date = params[:date]
    @event.save
    redirect to "/events/#{@event.id}"
  end

  post '/events/:id/gifts/:id2/edit' do
    redirect_if_not_logged_in
    @gift = Gift.find_by_id(params[:id2])
    @event = Event.find_by_id(params[:id])
    @gift.update(params[:gift])
    if !params[:giver][:name].empty?
      @giver = Giver.create(name: params[:giver][:name])
      @gift.givers << @giver
      @user.givers << @giver
    end
    @gift.save
    redirect to "/events/#{@event.id}"
  end

  get '/events/:id/delete' do
    redirect_if_not_logged_in
    @event = Event.find_by_id(params[:id])
    if @event.user_id == session[:user_id]
      @event.delete
      redirect to '/events'
    else
      redirect to '/events'
    end
  end

  get '/gifts/:id/delete' do
    redirect_if_not_logged_in
    @gift = Gift.find_by_id(params[:id])
    @event = Event.find_by_id(@gift.event.id)
    if @gift.event.user_id == session[:user_id]
      @gift.delete
      redirect to "/events/#{@event.id}"
    else
      redirect to "/events/#{@event.id}"
    end
  end

end
