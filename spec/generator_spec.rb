require 'test_helper.rb'
# require File.join(File.expand_path(File.dirname(__FILE__)), "../lib", "recaptchaed")
# include Recaptchaed
require 'rails_generator'
require 'rails_generator/scripts/generate'

describe Recaptchaed, 'generator' do 

  before(:all) do 
    FileUtils.mkdir_p(fake_initializers_dir)
    FileUtils.mkdir_p(fake_locales_dir)
    @original_config_files = config_file_list
    @original_initializers_files = initializers_file_list

    content = <<-END
      # Sample localization file for English. Add more files in this directory for other locales.
      # See http://github.com/svenfuchs/rails-i18n/tree/master/rails%2Flocale for starting points.

      en:
        hello: "Hello world"
    END
    File.open(fake_i18n_path, 'wb') {|f| f.write(content) }
  end

  after(:all) do 
    FileUtils.rm_r(fake_config_dir)
  end

  it "should generate a config file, an initializer, and add i18n error message" do 
    Rails::Generator::Scripts::Generate.new.run(["recaptchaed"], :destination => fake_rails_root)

    new_file = (config_file_list - @original_config_files).first
    File.basename(new_file).should == "recaptchaed.yml"

    new_file = (initializers_file_list - @original_initializers_files).first
    File.basename(new_file).should == "recaptchaed.rb"

    File.read(fake_i18n_path).should match(/recaptcha_response_field/)
  end

  # it "should remove config file, initializer, and should remove i18n error message" do
  #   Rails::Generator::Scripts::Destroy.new.run(["recaptchaed"], :destination => fake_rails_root)

  #   new_file = (config_file_list - @original_config_files)
  #   new_file.should be nil

  #   new_file = (initializers_file_list - @original_initializers_files)
  #   new_file.should be nil

  #   File.read(fake_i18n_path).should_not match(/recaptcha_response_field/)
  # end

  private

    def fake_rails_root
      File.join(File.dirname(__FILE__), 'rails_root')
    end

    def fake_initializers_dir
      @fake_initializers_dir ||= "#{fake_rails_root}/config/initializers"
    end

    def fake_config_dir
      @fake_config_dir ||= "#{fake_rails_root}/config"
    end

    def fake_locales_dir
      @fake_locales_dir ||= "#{fake_rails_root}/config/locales"
    end

    def fake_i18n_path
      @fake_i18n_path ||= "#{fake_rails_root}/config/locales/en.yml"
    end
  
    def config_file_list
      Dir.glob(File.join(fake_config_dir, "*"))
    end

    def initializers_file_list
      Dir.glob(File.join(fake_initializers_dir, "*"))
    end

end
