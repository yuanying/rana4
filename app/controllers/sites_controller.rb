class SitesController < ApplicationController
  before_filter :load_site
  
  # GET /sites/1/edit
  def edit
    
  end

  # PUT /sites/1
  # PUT /sites/1.xml
  def update

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to(root_url, :notice => 'Site was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected
  def load_site
    @site = Site.find(params[:id])
  end
end
