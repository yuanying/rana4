class ApplicationController < ActionController::Base
  protect_from_forgery
  unless Rails.env == 'production'
    CASClient::Frameworks::Rails::Filter.fake("yuanying")
  end
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :load_user
  
  protected
  def load_user
    @user = User.find_or_create_by_cas_id(session[:cas_user])
  end
  
  def load_site
    if params[:site_id]
      @site = Site.find(params[:site_id])
    end
  end
end
