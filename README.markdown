Recaptchaed
==========

Rails Plugin for adding [recaptcha](http://www.google.com/recaptcha) to a form. 

Install
==========

1. First, go to [recaptcha](http://www.google.com/recaptcha) and sign up for a api key.

2. Next, install the recaptchaed gem: 
    gem install recaptchaed
3. Tell Rails to use the gem
Open config/environment.rb and enter the following: 
    config.gem "recaptchaed"
4. Run the generator to create config files and to add customizable error messages
    script/generate recaptchaed
If it runs successfully, you should see the following: 
      create  config/recaptchaed.yml
      create  config/initializers/recaptchaed.rb
      added  recaptcha i18n error message to config/locales/en.yml
5. Edit the config/recaptcaed.yml file and add your personal recaptcha public and private api keys

Uninstall
==========

1. Run script/destroy recaptchaed

2. remove any related custom logic from your views and controllers

Example Usage
=============

This example shows how to protect a comment model with a recaptcha

1. Include the recaptcha javascript library in app/views/layouts/comments.html.erb. 

    <%=javascript_include_tag 'http://www.google.com/recaptcha/api/js/recaptcha_ajax.js' %>

2. Add the recaptcha markup to the app/views/comments/new.html.erb. 

    <h1>New comment</h1>
    
    <% form_for(@comment) do |f| %>
      <%= f.error_messages %>
    
      <p>
        <%= f.label :title %><br />
        <%= f.text_field :title %>
      </p>
      <p>
        <%= f.label :body %><br />
        <%= f.text_area :body %>
      </p>
      <%= recaptcha_tag (RECAPTCHAED["RECAPTCHA_PUBLIC_KEY"], "recaptcha_div", "blackglass") %>
      <p>
        <%= f.submit 'Create' %>
      </p>
    <% end %>
    
    <%= link_to 'Back', comments_path %>

The [recaptcha site](http://code.google.com/apis/recaptcha/docs/customization.html) has several options for different themes/styles. For example, you can change the theme of the recaptcha to 'white' by passing a different theme string.

    <%= recaptcha_tag (RECAPTCHAED["RECAPTCHA_PUBLIC_KEY"], "recaptcha_div", "white") %>

3. Add logic to create action inside the comments controller to validate the captcha. 

First, include the library in the comments controller: 

    class CommentsController < ApplicationController
      include Recaptchaed
      ...rest of controller...
    end

Then, protect the create method using the 'validate_captcha(..)' method

      # POST /comments
      # POST /comments.xml
      def create
        @comment = Comment.new(params[:comment])
    
        @recaptcha = validate_captcha(RECAPTCHAED["RECAPTCHA_PRIVATE_KEY"], request.remote_ip, params['recaptcha_challenge_field'], params['recaptcha_response_field'])
    
        respond_to do |format|
          if @recaptcha && @recaptcha['success'] && @comment.save	
            flash[:notice] = 'Comment was successfully created.'
            format.html { redirect_to(@comment) }
            format.xml  { render :xml => @comment, :status => :created, :location => @comment }
          else
            if(!@recaptcha['success'])
              @comment.errors.add('recaptcha_response_field', :"recaptcha.invalid")
            end
            format.html { render :action => "new" }
            format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
          end
        end
      end

When a user fails to enter the correct captcha, the error message that is displayed is defined inside 'config/locales/en.yml'. Feel free to update that to whatever you like. And, it can also be internationalized, if needed. 

Enjoy!

http://upgradingdave.com
Copyright (c) 2010 Dave Paroulek, released under the MIT license
