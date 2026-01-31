class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    
    if @contact.save
      redirect_to about_path, notice: "Thanks! I have received your message."
    else
      redirect_to about_path, alert: "Something went wrong. Please try again."
    end
  end

  private

  def contact_params
    params.permit(:name, :email, :message)
  end
end