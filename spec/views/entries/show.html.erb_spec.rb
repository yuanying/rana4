require 'spec_helper'

describe "entries/show.html.erb" do
  before(:each) do
    @entry = assign(:entry, stub_model(Entry,
      :title => "Title",
      :path => "Path",
      :is_public => false,
      :format_type => "Format Type",
      :description => "MyText",
      :body_text => "MyText",
      :extend_text => "MyText",
      :site_id => 1,
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Title".to_s)
    rendered.should contain("Path".to_s)
    rendered.should contain(false.to_s)
    rendered.should contain("Format Type".to_s)
    rendered.should contain("MyText".to_s)
    rendered.should contain("MyText".to_s)
    rendered.should contain("MyText".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
  end
end
