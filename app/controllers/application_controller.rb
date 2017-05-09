require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "gifts"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user = User.find(session[:user_id])
    end
  end

  get '/' do
    erb :home
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect to '/events'
  end

end
