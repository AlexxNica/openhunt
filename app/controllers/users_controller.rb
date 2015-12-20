class UsersController < ApplicationController
  before_filter :require_user, only: [:ban, :unban]

  def show
    load_user

    load_voted_projects
    load_submitted_projects

    if current_user.present?
      @vote_ids = current_user.match_votes((@voted_projects+@submitted_projects).map(&:id))
    end
  end

  def ban
    load_user

    result = current_user.ban_user(@user)
    redirect_url = "/@#{@user.screen_name}"
    redirect_to "/audit/#{result.id}/edit?redirect_url=#{redirect_url}"
  end

  def unban
    load_user

    result = current_user.unban_user(@user)
    redirect_url = "/@#{@user.screen_name}"
    redirect_to "/audit/#{result.id}/edit?redirect_url=#{redirect_url}"
  end

  def make_moderator
    load_user

    result = current_user.make_moderator(@user)
    redirect_url = "/@#{@user.screen_name}"
    redirect_to "/audit/#{result.id}/edit?redirect_url=#{redirect_url}"
  end

  def remove_moderator
    load_user

    result = current_user.remove_moderator(@user)
    redirect_url = "/@#{@user.screen_name}"
    redirect_to "/audit/#{result.id}/edit?redirect_url=#{redirect_url}"
  end

  protected
  def load_user
    @user = User.where(screen_name: params[:screen_name]).first
  end

  def load_voted_projects
    @voted_projects = @user.voted_projects.order(:votes_count => :desc)
  end

  def load_submitted_projects
    @submitted_projects = @user.submitted_projects.order(:votes_count => :desc)
  end
end
