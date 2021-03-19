class ReservationsController < ApplicationController

  def create
    parsed_params = params.permit!.to_hash
    user_attrs, reservation_attrs = ApplicationRecord.user_and_reservation_attribute_builder(attributes_hash: parsed_params)
    user = User.find_or_create_by! user_attrs
    reservation = user.reservations.create!(reservation_attrs)

    render json: {
      guest: user,
      reservation: reservation
    }, status: :ok
    
  end

end