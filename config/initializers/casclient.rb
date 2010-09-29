require 'casclient'
require 'casclient/frameworks/rails/filter'

CASClient::Frameworks::Rails::Filter.configure(
    :cas_base_url => "http://login.fraction.jp/",
    :username_session_key => :cas_user
)
