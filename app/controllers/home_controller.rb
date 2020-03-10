require './config/environment'

class HomeController < ApplicationController

    get "/my-builds/create-new" do
        @user = User.find_by(id: params[:id])
        erb :'homes/new'
    end

    post "/my-builds" do
        @user = current_user
        if params[:name].empty?
            redirect '/my-builds/create-new' 
        end  
        @home = Home.create(name: params[:name], type_of_home: params[:type_of_home], size: params[:size], bedrooms: params[:bedrooms], bathrooms: params[:bathrooms], location: params[:location], :user_id => @user.id)
        redirect '/my-builds'
    end

    get '/my-builds' do
        
        if !logged_in?
            redirect '/login'
         elsif logged_in? 
           @homes = current_user.homes
            @user = current_user #User.find(session[:user_id])
            erb :'homes/index'
          end
    end

    get '/my-builds/:id' do
        @home = Home.find(params[:id])
        if !logged_in?
            redirect '/login'
        elsif current_user.id != @home.user_id
            redirect '/my-builds'
        end
        erb :'/homes/show'
    end

    get '/my-builds/:id/edit' do
        if !logged_in?
            redirect '/login'
        end
         @home = Home.find(params[:id])
        #  if current_user.id != @home.user_id
        #      redirect '/my-bulds'
        #  end
        erb :'/homes/edit'
    end

    patch '/my-builds/:id' do
        @home = current_user.homes.find_by(id: params[:id])
        if !params.empty?
            @home.update(name: params[:name], type_of_home: params[:type_of_home], size: params[:size], bedrooms: params[:bedrooms], bathrooms: params[:bathrooms], location: params[:location])

            redirect "/my-builds/#{params[:id]}"
        else
            redirect "/my-builds/#{params[:id]}/edit"
        end
    end


end
