class GiversController < ApplicationController

  get '/givers' do
    redirect_if_not_logged_in
    @user = current_user
    @givers = @user.givers
    erb :'givers/givers'
  end

end
