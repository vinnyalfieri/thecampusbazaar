class CommunitiesController < ApplicationController
  # before_filter :authorize

  def index
    if !current_user
      render 'static_pages/home'
    end
  end
end
