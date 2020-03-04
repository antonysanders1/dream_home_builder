require './config/environment'

class HomeController < ApplicationController

    get "users/:id/new" do
        @user = User.find_by(id: params[:id])
        erb :'homes/new'
    end

end
