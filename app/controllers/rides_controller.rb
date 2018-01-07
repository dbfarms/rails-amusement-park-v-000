class RidesController < ApplicationController
    
    def new 
        @user = User.find(params[:user_id])
        #@attraction = Attraction.find(params[:attraction_id])
        @ride = Ride.create(:user_id => params[:user_id], :attraction_id => params[:attraction_id])
        @message = @ride.take_ride 
        
        redirect_to user_path(@ride.user, :message => @message)
        
    end 
end
