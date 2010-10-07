require 'spec_helper'

describe "attachments/index.html.erb" do
  before(:each) do
    assign(:attachments, [
      stub_model(Attachment,
        :disk_filename => "Disk Filename",
        :filename => "Filename",
        :content_type => "Content Type",
        :width => 1,
        :height => 1,
        :size => 1,
        :entry_id => 1
      ),
      stub_model(Attachment,
        :disk_filename => "Disk Filename",
        :filename => "Filename",
        :content_type => "Content Type",
        :width => 1,
        :height => 1,
        :size => 1,
        :entry_id => 1
      )
    ])
  end

  it "renders a list of attachments" do
    render
    rendered.should have_selector("tr>td", :content => "Disk Filename".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Filename".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Content Type".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
