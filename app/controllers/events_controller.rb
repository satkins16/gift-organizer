class EventsController < ApplicationController

  get '/events' do
    redirect_if_not_logged_in
    
  end

end
