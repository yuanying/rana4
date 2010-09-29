require 'spec_helper'

describe "entries/edit.html.erb" do
  before(:each) do
    @entry = assign(:entry, stub_model(Entry,
      :new_record? => false,
      :title => "MyString",
      :path => "MyString",
      :is_public => false,
      :format_type => "MyString",
      :description => "MyText",
      :body_text => "MyText",
      :extend_text => "MyText",
      :site_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit entry form" do
    render

    rendered.should have_selector("form", :action => entry_path(@entry), :method => "post") do |form|
      form.should have_selector("input#entry_title", :name => "entry[title]")
      form.should have_selector("input#entry_path", :name => "entry[path]")
      form.should have_selector("input#entry_is_public", :name => "entry[is_public]")
      form.should have_selector("input#entry_format_type", :name => "entry[format_type]")
      form.should have_selector("textarea#entry_description", :name => "entry[description]")
      form.should have_selector("textarea#entry_body_text", :name => "entry[body_text]")
      form.should have_selector("textarea#entry_extend_text", :name => "entry[extend_text]")
      form.should have_selector("input#entry_site_id", :name => "entry[site_id]")
      form.should have_selector("input#entry_user_id", :name => "entry[user_id]")
    end
  end
end
