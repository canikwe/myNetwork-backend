class Api::V1::ContactsController < ApplicationController
  before_action :get_contact, only: [:destroy]

  def destroy
    
    contact = @contact
    @contact.destroy
    render json: contact, status: :accepted
  end

  private
  def get_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:id)
  end
end
