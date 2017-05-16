class GiftsController < ApplicationController

  get '/gifts/new' do
    redirect_if_not_logged_in
    @event =
    erb :'gifts/new'
  end

end
