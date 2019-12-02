require './config/environment'

class StoryController < ApplicationController

  use Rack::Flash

  get '/storys' do
    redirect_if_not_logged_in

    @user = current_user
    @storys = Story.all
    erb :'storys/index'
  end

  get '/storys/new' do
    redirect_if_not_logged_in

    @user = current_user
    erb :'storys/new'
  end

  get '/storys/:id' do
    redirect_if_not_logged_in

    @story = Story.find_by_id(params[:id])
    @creator = User.find_by_id(@story.user_id)
    @user = current_user
    erb :'storys/show'
  end

  get '/storys/:id/edit' do
    redirect_if_not_logged_in
    @story = Story.find_by_id(params[:id])
    redirect_if_not_creator(@story)

    erb :'storys/edit'
  end

  post '/storys' do
    @story = Story.create(params[:story])
    bookmark = Bookmark.create(user_id: current_user.id, story_id: @story.id)

    if !!@story.id
      redirect "/storys/#{@story.id}"
    else
      flash[:message] = ""
      redirect '/storys/new'
    end
  end

  patch '/storys/:id' do
    @story = Story.find_by_id(params[:id])

    redirect_if_not_creator(@story)

    @story.update(params[:story])
    @story.save
    redirect "/storys/#{@story.id}"
  end

  delete '/storys/:id/delete' do
    @story = Story.find_by_id(params[:id])
    @story.destroy

    @bookmarks = Bookmark.all.each do |b|
      if b.story_id == params[:id].to_i
        b.destroy
      end
    end

    redirect '/storys'
  end


  patch '/storys/:id/add' do
    @story = Story.find_by_id(params[:id])
    current_user.add_bookmark(@story)
    redirect "/users/#{current_user.id}/bookmarks"
  end

  patch '/storys/:id/remove' do
    @storys = Story.find_by_id(params[:id])
    current_user.remove_bookmark(@Story)
    redirect "/users/#{current_user.id}/bookmarks"
  end

end
