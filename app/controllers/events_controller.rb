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
  end

end
