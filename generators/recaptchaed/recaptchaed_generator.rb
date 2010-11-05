require 'rails_generator'
require 'rails_generator/commands'

module Recaptchaed #:nodoc:
  module Generator #:nodoc:
    module Commands #:nodoc:
# This is the text we want to apped to the end of config/locales/en.yml: 
CONTENT = <<END

en:  
  activerecord:
    errors:
      full_messages: 
        recaptcha:
          invalid: "{{message}}"
      models:
        comment:
          attributes:
            recaptcha_response_field:
              recaptcha:
                invalid: "The characters you entered didn't quite match up to the image. Please make sure to match the letters in the image exactly."
END

      I18N_PATH = 'config/locales/en.yml'

      module Create
        def recaptcha_i18n
          logger.added "recaptcha i18n error message to #{I18N_PATH}"
          look_for = '$'
          unless options[:pretend]
            gsub_file(I18N_PATH, /\z/mi){|match| "#{match}\n  #{CONTENT}\n"}
          end
        end
      end

      module Destroy
        def recaptcha_i18n
          logger.removed "recaptcha i18n error message from #{I18N_PATH}"
          gsub_file I18N_PATH, /#{Regexp.escape(CONTENT)}/mi, ''
        end
      end

      module List
        def recaptcha_i18n
        end
      end

      module Update
        def recaptcha_i18n
        end
      end
    end
  end
end

Rails::Generator::Commands::Create.send   :include,  Recaptchaed::Generator::Commands::Create
Rails::Generator::Commands::Destroy.send  :include,  Recaptchaed::Generator::Commands::Destroy
Rails::Generator::Commands::List.send     :include,  Recaptchaed::Generator::Commands::List
Rails::Generator::Commands::Update.send   :include,  Recaptchaed::Generator::Commands::Update

class RecaptchaedGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file "recaptchaed.yml", "config/recaptchaed.yml"
      m.file "recaptchaed.rb", "config/initializers/recaptchaed.rb"
      m.recaptcha_i18n
    end
  end
end
