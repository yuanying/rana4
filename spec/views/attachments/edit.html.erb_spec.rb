require 'spec_helper'

describe "attachments/edit.html.erb" do
  before(:each) do
    @attachment = assign(:attachment, stub_model(Attachment,
      :new_record? => false,
      :disk_filename => "MyString",
      :filename => "MyString",
      :content_type => "MyString",
      :width => 1,
      :height => 1,
      :size => 1,
      :entry_id => 1
    ))
  end

  it "renders the edit attachment form" do
    render

    rendered.should have_selector("form", :action => attachment_path(@attachment), :method => "post") do |form|
      form.should have_selector("input#attachment_disk_filename", :name => "attachment[disk_filename]")
      form.should have_selector("input#attachment_filename", :name => "attachment[filename]")
      form.should have_selector("input#attachment_content_type", :name => "attachment[content_type]")
      form.should have_selector("input#attachment_width", :name => "attachment[width]")
      form.should have_selector("input#attachment_height", :name => "attachment[height]")
      form.should have_selector("input#attachment_size", :name => "attachment[size]")
      form.should have_selector("input#attachment_entry_id", :name => "attachment[entry_id]")
    end
  end
end
