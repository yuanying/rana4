require 'spec_helper'

describe "attachments/show.html.erb" do
  before(:each) do
    @attachment = assign(:attachment, stub_model(Attachment,
      :disk_filename => "Disk Filename",
      :filename => "Filename",
      :content_type => "Content Type",
      :width => 1,
      :height => 1,
      :size => 1,
      :entry_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Disk Filename".to_s)
    rendered.should contain("Filename".to_s)
    rendered.should contain("Content Type".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
  end
end
