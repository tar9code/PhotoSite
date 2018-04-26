class PhotoController < ApplicationController
  def index
    @id = params[:id]
    @user = User.find(@id)
    #@photos = Photo.find_by_user_id(@id)
    @photos = Photo.where(user_id: @id)
    #@user = User.find(params[:id])
    #@photos = Photo.find_by_user_id(params[:id])

  end
end
