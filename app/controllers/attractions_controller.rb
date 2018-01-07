class AttractionsController < ApplicationController
    
    def index 
        @user = User.find(session[:user_id])
        @attractions = Attraction.all
    end 
    
    def show
        @user = User.find(session[:user_id])
        set_attraction
    end 
    
    def new 
        @attraction = Attraction.new
    end 
    
    def create
        @attraction = Attraction.create(attraction_params)
        redirect_to attraction_path(@attraction)
    end 
    
    def edit 
        set_attraction
    end 
    
    def update 
      #binding.pry
      set_attraction
      respond_to do |format|
        if @attraction.update(attraction_params)
            format.html { redirect_to @attraction, notice: 'Attraction was successfully updated.' }
        else
            format.html { render :edit }
        end
      end 
    end 
    
    def destroy
      @attraction.destroy
      respond_to do |format|
        format.html { redirect_to attractions_url, notice: 'Attraction was successfully destroyed.' }
      end
    end

    
    private 
    
    def set_attraction 
        @attraction = Attraction.find(params[:id])
    end 
    
    def attraction_params
      params.require(:attraction).permit( 
        :name,
        :min_height,
        :tickets,
        :happiness_rating,
        :nausea_rating
      )
    end
end
