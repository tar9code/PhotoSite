class UserController < ApplicationController
  def index
  @users_all = User.all

  end
end
