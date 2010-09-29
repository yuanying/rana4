require 'spec_helper'

describe "sites/new.html.erb" do
  before(:each) do
    assign(:site, stub_model(Site,
      :new_record? => true,
      :title => "MyString",
      :description => "MyText",
      :url => "MyString",
      :path => "MyString",
      :timezone => "MyString"
    ))
  end

  it "renders new site form" do
    render

    rendered.should have_selector("form", :action => sites_path, :method => "post") do |form|
      form.should have_selector("input#site_title", :name => "site[title]")
      form.should have_selector("textarea#site_description", :name => "site[description]")
      form.should have_selector("input#site_url", :name => "site[url]")
      form.should have_selector("input#site_path", :name => "site[path]")
      form.should have_selector("input#site_timezone", :name => "site[timezone]")
    end
  end
end
