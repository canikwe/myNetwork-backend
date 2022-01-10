class Api::V1::EncountersController < ApplicationController
    before_action :get_encounter, only: [:destroy]
    skip_before_action :authorized

  def create
    encounter = Encounter.new(encounter_params)
    # 'call'.verb.conjugate :subject => 'Matz', tense: :past, aspect: :perfective
    encounter.verb = encounter.verb.verb.conjugate tense: :past, aspect: :perfective

    if encounter.save
      render json: encounter, status: :created
    else
      render json: {message: encounter.errors.full_messages}, status: :not_acceptable
    end
  end

  def destroy
    encounter = @encounter
    @encounter.destroy
    render json: encounter, status: :accepted
  end

  private
  def encounter_params
    params.require(:encounter).permit(:contact_id, :reminder_id, :verb, :details, :rating, :date)
  end

  def get_encounter
    @encounter = Encounter.find(params[:id])
  end
end
