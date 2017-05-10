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

  post '/login' do
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/events'
    else
      redirect to '/login'
    end
  end

end
