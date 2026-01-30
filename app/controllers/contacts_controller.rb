class ContactsController < ApplicationController
  def create
    # For now, we just log the message to the server console
    puts ">>> NEW MESSAGE from #{params[:name]} (#{params[:email]}): #{params[:message]}"
    
    redirect_to about_path, notice: "Thanks for your message! I'll be in touch soon."
  end
end