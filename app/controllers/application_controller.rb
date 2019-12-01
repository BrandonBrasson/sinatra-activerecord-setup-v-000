require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "story"
  end

  get "/" do
    if is_logged_in?
      redirect '/storys'
    else
      erb :index
    end
  end

  helpers do

    def current_user
      @user = User.find_by_id(session[:user_id])
    end

    def is_logged_in?
      !!current_user
    end

    def redirect_if_not_logged_in
      if !is_logged_in?
        flash[:message] = " log in to view  page."
        redirect "/"
      end
    end

    def redirect_if_not_creator(story)
      if current_user.id != story.user_id
        flash[:message] = ""
        redirect "/storys/#{story.id}"
      end
  end
end
end
 
