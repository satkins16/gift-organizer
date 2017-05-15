class GiftsController < ApplicationController

  get '/gifts/new' do
    redirect_if_not_logged_in
    erb :'gifts/new'
  end

end
