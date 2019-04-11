class Api::V1::ContactsController < ApplicationController
  before_action :get_contact, only: [:destroy, :update]

  def destroy 
    contact = @contact
    @contact.destroy
    render json: contact, status: :accepted
  end

  def update
    # byebug
    @contact.requested.update(contact_params[:requested_attributes])
    render json: ContactSerializer.new(@contact)
  end

  private
  def get_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(contact_info: [:id, :requested_id], requested_attributes: [:first_name, :last_name, :id])
  end
end
