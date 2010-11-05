require 'test_helper.rb'
require 'rubygems'
require 'action_view'
include ActionView::Helpers::FormTagHelper
include ActionView::Helpers::TagHelper

describe Recaptchaed, 'form_tag' do
  it "should add a form helper" do
    recaptcha_tag("12345", "test", "blackglass").should == "<div id=\"test\"></div>
                <script type=\"text/javascript\">
                   Recaptcha.create('12345', 'test', { theme: 'blackglass' })
                </script>"
  end
end
