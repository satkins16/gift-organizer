require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    use Rack::Flash
    set :session_secret, "gifts"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect to "/login"
      end
    end

    def current_user
      @user = User.find(session[:user_id])
    end
  end

  get '/' do
    if !logged_in?
      erb :home
    else
      redirect to '/events'
    end
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect to '/events'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect to '/events'
    end
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/events'
    else
      flash[:error] = "Email or password is incorrect"
      redirect to '/login'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      flash[:error] = "Please fill out all fields"
      redirect to '/signup'
    else
      @user = User.create(name: params[:name], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/events'
    end
  end

  get '/logout' do
    redirect_if_not_logged_in
    session.destroy
    redirect to '/'
  end

end
