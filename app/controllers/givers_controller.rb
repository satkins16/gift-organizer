class GiversController < ApplicationController

  get '/givers' do
    redirect_if_not_logged_in
    @user = current_user
    @givers = @user.givers
    erb :'givers/givers'
  end

  get '/givers/:id' do
    redirect_if_not_logged_in

  end

  get '/givers/:id/delete' do
    redirect_if_not_logged_in
    @giver = Giver.find_by_id(params[:id])
    if @giver.user_id == session[:user_id]
      @giver.delete
      redirect to "/givers"
    else
      redirect to "/givers"
    end
  end

end
