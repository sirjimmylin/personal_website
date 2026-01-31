module Admin
  class ContactsController < ApplicationController
    def index
      @contacts = Contact.order(created_at: :desc)
    end

    def destroy
      @contact = Contact.find(params[:id])
      @contact.destroy
      redirect_to admin_contacts_path, notice: "Message deleted."
    end
  end
end