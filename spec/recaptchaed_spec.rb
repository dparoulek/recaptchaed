require 'test_helper.rb'
include Recaptchaed

## 
# its kind of a pain to test this because, by nature, a captcha
# shouldn't be able to be programmatically solved. So, to test, go to
# a page with a form protected by recaptcha. View the source and update the
# corresponding values below from the recaptcha form that is generated

REMOTE_IP="changeme"
CHALLENGE_FIELD="changeme"
RESPONSE_FIELD="changeme"

describe Recaptchaed, "#validate_captcha" do
  it "should return true when valid captcha is submitted" do
    result = validate_captcha(RECAPTCHAED["RECAPTCHA_PRIVATE_KEY"], REMOTE_IP, CHALLENGE_FIELD, RESPONSE_FIELD)
    puts "Success: #{result['success']}, Message: #{result['message']}"
    result['success'].should be true
  end
end

