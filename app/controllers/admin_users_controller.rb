class UsersAdminController < ApplicationController
  before_action :find_user

  def approve
    @user.approved!
  end

  def cancel
    @user.declined!
  end

  def ban
    @user.blocked!
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
