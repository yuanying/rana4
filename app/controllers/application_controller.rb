class ApplicationController < ActionController::Base
  protect_from_forgery
  unless Rails.env == 'production'
    CASClient::Frameworks::Rails::Filter.fake("yuanying")
  end
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :load_user
  
  def render_to_body(options)
    @screeen_id = "#{options[:prefix]}/#{options[:template]}"
    super
  end
  
  protected
  def load_user
    @user = User.find_or_create_by_cas_id(session[:cas_user])
  end
  
  def load_site
    if params[:site_id]
      @site = Site.find(params[:site_id])
    end
  end
  
  def check_site_authorization
    unless @user.author?(@site)
      render(:text => 'Invalid Authorization.', :status => 403)
      return false
    end
  end
end
