require './config/environment'

class UserController < ApplicationController

    post'/signup' do
        @user = User.new(name: params[:name], email: params[:email], password: params[:password])
        if @user.save && @user.name != "" && @user.email != "" && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{params[:id]}"
        else
            redirect '/welcome'
        end
      end

      get '/users/:id' do
        @user = User.find_by(id: params[:id])
        erb :"users/show"
      end

end
