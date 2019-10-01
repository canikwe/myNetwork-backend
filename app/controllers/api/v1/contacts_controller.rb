class Api::V1::ContactsController < ApplicationController
  before_action :get_contact, only: [:destroy, :update]

  def destroy
    contact = @contact
    @contact.destroy
    render json: contact, status: :accepted
  end

  def update
    @contact.update(contact_params[:contact_info])
    @contact.requested.update(contact_params[:requested_attributes])
    render json: ContactSerializer.new(@contact)
  end

  def create
    byebug
    contact = Contact.new(contact_params)
    if contact.save
      render json: ContactSerializer.new(contact)
    else
      render json: {message: "Ooop, dat ain't it"}
    end
  end

  private
  def get_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:id, :first_name, :last_name, :kind, :details, :user_id)
  end
end
