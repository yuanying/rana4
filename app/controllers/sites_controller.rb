class SitesController < ApplicationController
  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])
  end

  # PUT /sites/1
  # PUT /sites/1.xml
  def update
    @site = Site.find(params[:id])

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
end
