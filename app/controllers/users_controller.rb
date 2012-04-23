# coding: utf-8

class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success]="アカウントの作成が完了しました。WCorkBoardへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "ログインしてください"
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
