class Ride < ActiveRecord::Base
    belongs_to :user
    belongs_to :attraction 

    def requirements
        if self.user.tickets < self.attraction.tickets
            tickets_enough = false
        else 
            tickets_enough = true 
        end 
        
        if self.user.height < self.attraction.min_height
            tall_enough = false 
        else 
            tall_enough = true 
        end 
        
        return [tickets_enough, tall_enough]    
    end 
    
    def take_ride #(user_id, attraction_id)
         #   flash = { tickets: "Sorry. You do not have enough tickets to ride the #{attraction.name}."}
        #    flash = { ht: "Sorry. You are not tall enough to ride the #{attraction.name}." }
        enough_tickets, enough_height = requirements
        
        if enough_tickets && enough_height 
            ride_over 
        elsif enough_tickets && !enough_height 
            "Sorry. You are not tall enough to ride the #{attraction.name}."
        elsif !enough_tickets && enough_height
            "Sorry. You do not have enough tickets to ride the #{attraction.name}."
        elsif !enough_tickets && !enough_height
            "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
        end 
            
    end 
    
    def ride_over 
        new_tickets = self.user.tickets - self.attraction.tickets 
        new_nausea = self.user.nausea + self.attraction.nausea_rating 
        new_happy = self.user.happiness + self.attraction.happiness_rating
        self.user.update(
            :happiness => new_happy,
            :nausea => new_nausea,
            :tickets => new_tickets
        )
        "Thanks for riding the #{self.attraction.name}!"
    end 
    
end
