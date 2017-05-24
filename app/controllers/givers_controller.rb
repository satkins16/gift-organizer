class GiversController < ApplicationController

  get '/givers' do
    redirect_if_not_logged_in
    @user = current_user
    @gifts = @user.gifts
    erb :'givers/givers'
  end

end
