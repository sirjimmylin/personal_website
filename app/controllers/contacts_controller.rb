class ContactsController < ApplicationController
  def create
    # This prints the message to your terminal (where rails server is running)
    puts ">>> MESSAGE RECEIVED from #{params[:name]}"
    
    redirect_to about_path, notice: "Message sent!"
  end
end