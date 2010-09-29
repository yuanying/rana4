# -*- coding: utf-8 -*- 
require 'spec_helper'

describe User do
  it "正常に保存できること" do
    @user = Factory.build(:mike)
    @user.save.should be_true
  end
end
