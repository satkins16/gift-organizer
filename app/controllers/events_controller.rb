class EventsController < ApplicationController

  get '/events' do
    redirect_if_not_logged_in
    @events = User.events
    erb :'events/events'
  end

end
