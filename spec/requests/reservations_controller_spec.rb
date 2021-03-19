require 'rails_helper'
require 'spec_helper'

RSpec.describe ReservationsController do

  let(:guest_email) { "wayne_woodbridge@bnb.com" }
  let(:guest_first_name) { "Wayne" }
  let(:guest_last_name) { "Woodbridge" }
  let(:start_date) { "2020-03-12" }
  let(:end_date) { "2020-03-16" }
  let(:security_price) { "500.00" }
  let(:host_currency) { "AUD" }
  let(:nights) { 4 }
  let(:status_type) { "accepted" }
  let(:total_paid_amount_accurate) { "4500.00" }
  let(:phone_numbers) {
    [ 
      "639123456789", 
      "639123456789" 
    ]
  }
  let(:expected_payout_amount) { "3800.00" }
  let(:adults) { 2 }
  let(:children) { 2 }
  let(:infants) { 0 }
  let(:payload) {
    { 
      "reservation": {
        "start_date": start_date, 
        "end_date": end_date, 
        "expected_payout_amount": expected_payout_amount, 
        "guest_details": {
          "localized_description": "4 guests", 
          "number_of_adults": adults, 
          "number_of_children": children, 
          "number_of_infants": infants
        }, 
        "guest_email": guest_email, 
        "guest_first_name": guest_first_name, 
        "guest_id": 1, 
        "guest_last_name": guest_last_name, 
        "guest_phone_numbers": phone_numbers, 
        "listing_security_price_accurate": security_price, 
        "host_currency": host_currency, 
        "nights": nights, 
        "number_of_guests": 4, 
        "status_type": status_type, 
        "total_paid_amount_accurate": total_paid_amount_accurate, 
      }
    }
  }

  shared_examples 'it successfully creates the reservation for a guest' do
    it 'saves the reservation accordingly' do
      post "/reservations", params: payload
      json_response = JSON.parse response.body
      guest = User.find json_response['guest']['id']
      reservation = guest.reservations.first
      reservation_contacts = reservation.reservation_contacts

      expect(guest.email).to eq(guest_email)
      expect(guest.first_name).to eq(guest_first_name)
      expect(guest.last_name).to eq(guest_last_name)

      expect(reservation.nights).to eq(nights)
      expect(reservation.number_of_adults).to eq(adults)
      expect(reservation.number_of_children).to eq(children)
      expect(reservation.number_of_infants).to eq(infants)
      expect("%.2f" % reservation.total_paid_amount_accurate.to_i).to eq(total_paid_amount_accurate)
      expect(reservation.listing_security_price_accurate.to_i).to eq(security_price.to_i)
      expect("%.2f" % reservation.expected_pay_amount).to eq(expected_payout_amount)
      expect(reservation.start_date.strftime('%Y-%m-%d')).to eq(start_date)
      expect(reservation.end_date.strftime('%Y-%m-%d')).to eq(end_date)

      if phone_numbers.is_a?(Array)
        expect(phone_numbers.sort).to eq(reservation_contacts.map(&:number).sort)
      else
        expect(phone_numbers).to eq(reservation_contacts.first.number)
      end
    end 
  end
  
  context "when creating a reservation with a reservation key in the params" do
    include_examples 'it successfully creates the reservation for a guest'
  end

  context "when creating a reservation with shuffled keys" do
    let(:phone_numbers) { "639123456789" }
    let(:security_price) { "500" }
    let(:payload) {
      { 
        "start_date": start_date, 
        "end_date": end_date, 
        "nights": nights, 
        "guests": 4, 
        "adults": adults, 
        "children": children, 
        "infants": infants, 
        "status": status_type, 
        "guest": { 
          "id": 1, 
          "first_name": guest_first_name, 
          "last_name": guest_last_name, 
          "phone": phone_numbers, 
          "email": guest_email
        }, 
        "currency": host_currency, 
        "payout_price": expected_payout_amount, 
        "security_price": security_price, 
        "total_price":  total_paid_amount_accurate
      }
    }

    include_examples 'it successfully creates the reservation for a guest'
  end

end