class UsersController < ApplicationController
    
    def new 
        @user = User.new 
    end 
    
    def create 
        @user = User.create(user_params)
        if @user.save 
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        else 
            redirect_to root_path
        end 
    end 

    def show 
        
        @message = params[:message] if params[:message]
        @message ||= false
        
        if logged_in?
            @user = set_user
        else 
            redirect_to '/'
        end 
    end 

    private
    
    def user_params 
        params.require(:user).permit(:name, :height, :happiness, :nausea, :admin, :tickets, :password)
    end 
    
    def set_user 
        User.find(params[:id])
    end 
    
end
