class WelcomeController < ApplicationController
  def index
    @sites = Site.written_by(@user)
  end
end
