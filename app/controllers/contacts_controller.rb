class ContactsController < ApplicationController
  def index
    @contacts = User.all
  end

  def create

  end

  def destroy
    User.find(params[:id]).delete
  end
end
