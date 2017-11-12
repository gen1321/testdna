# coding: utf-8
class UsersAdminController < ApplicationController
  before_action :find_user

  def approve
    @user.approved!
    redirect_to admin_path, flash: { notice: 'Юзер подтвержден' }
  end

  def cancel
    @user.declined!
    redirect_to admin_path, flash: { notice: 'Регистрация пользователя отменена' }
  end

  def ban
    @user.banned!
    redirect_to admin_path, flash: { notice: 'Юзер Забанен' }
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
