class ContactsController < ApplicationController
  def index
    @contacts = User.all
  end

  def create

  end

  def destroy
    user = User.find(params[:id]).delete
    render json: user
  end
end
