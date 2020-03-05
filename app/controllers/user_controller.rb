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

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/home'
      else
        redirect '/login'
      end
    end

    get '/logout' do
        if logged_in?
          session.clear
          redirect '/login'
        else !logged_in?
          redirect '/home'
        end
      end

    

end
