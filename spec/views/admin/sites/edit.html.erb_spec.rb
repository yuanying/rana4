require 'spec_helper'

describe "admin_sites/edit.html.erb" do
  before(:each) do
    @site = assign(:site, stub_model(Admin::Site,
      :new_record? => false
    ))
  end

  it "renders the edit site form" do
    render

    rendered.should have_selector("form", :action => site_path(@site), :method => "post") do |form|
    end
  end
end
