require './config/environment'

class UserController < ApplicationController

    post'/signup' do
        @user = User.new(name: params[:name], email: params[:email], password: params[:password])
        if @user.save && @user.name != "" && @user.email != "" && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/home"
        else
            redirect '/'
        end
      end


      get '/home' do
        if !logged_in?
            redirect '/'
         elsif logged_in?
            @user = current_user 
            erb :'users/show'
          end
        end

end
