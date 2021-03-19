class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

   # For User
   FIRST_NAME_PROBABLE_KEYS = ['first_name', 'guest_first_name'] # Can just add more here
   LAST_NAME_PROBABLE_KEYS = ['guest_last_name']
   EMAIL_PROBABLE_KEYS = ['guest_email']
   USER_EXPECTED_ATTRIBUTES = ['email', 'first_name', 'last_name'].sort.freeze
 
   # For Reservation
   HOST_CURRENCY_PROBABLE_KEYS = ['currency']
   NUMBER_OF_INFANT_PROBABLE_KEYS = ['infants']
   NUMBER_OF_CHILDREN_PROBABLE_KEYS = ['children']
   NUMBER_OF_ADULTS_PROBABLE_KEYS = ['adults']
   EXPECTED_PAYOUT_AMOUNT_PROBABLE_KEYS = ['payout_price', 'expected_payout_amount']
   SECURITY_PRICE_PROBABLE_KEYS = ['security_price']
   TOTAL_PAID_AMOUNT_ACCURATE_PROBABLE_KEYS = ['total_price']
   STATUS_PROBABLE_KEYS = ['status_type']
   UNEXPECTED_RESERVATION_KEYS = ['user_id', 'created_at', 'updated_at'].freeze
   RESERVATION_EXPECTED_ATTRIBUTES = (Reservation.columns.map(&:name) - UNEXPECTED_RESERVATION_KEYS).sort.freeze
 
   # Phone number
   PHONE_NUMBER_PROBABLE_KEYS = ['phone', 'guest_phone_numbers']

  def self.user_and_reservation_attribute_builder(attributes_hash:, user_hash: {}, reservation_hash: {}, phone_numbers: { reservation_contacts_attributes: [] })
    user_hash.merge!(attributes_hash.slice(*USER_EXPECTED_ATTRIBUTES))
    reservation_hash.merge!(attributes_hash.slice(*RESERVATION_EXPECTED_ATTRIBUTES))
    keys_checker = -> { 
      user_hash.keys.sort == USER_EXPECTED_ATTRIBUTES &&
      (reservation_hash.keys - [:reservation_contacts_attributes]).sort == RESERVATION_EXPECTED_ATTRIBUTES
    }

    unless keys_checker.call
      attributes_hash.each do |key, value|

        if value.is_a?(Hash)
          user_and_reservation_attribute_builder(attributes_hash: value, user_hash: user_hash, reservation_hash: reservation_hash, phone_numbers: phone_numbers)
        end

        case key
        when *FIRST_NAME_PROBABLE_KEYS
          user_hash['first_name'] = value
        when *LAST_NAME_PROBABLE_KEYS
          user_hash['last_name'] = value 
        when *EMAIL_PROBABLE_KEYS
          user_hash['email'] = value
        when *STATUS_PROBABLE_KEYS
          reservation_hash['status'] = value
        when *HOST_CURRENCY_PROBABLE_KEYS
          reservation_hash['host_currency'] = value
        when *NUMBER_OF_INFANT_PROBABLE_KEYS
          reservation_hash['number_of_infants'] = value 
        when *NUMBER_OF_CHILDREN_PROBABLE_KEYS
          reservation_hash['number_of_children'] = value
        when *NUMBER_OF_ADULTS_PROBABLE_KEYS
          reservation_hash['number_of_adults'] = value
        when *SECURITY_PRICE_PROBABLE_KEYS
          reservation_hash['listing_security_price_accurate'] = value
        when *EXPECTED_PAYOUT_AMOUNT_PROBABLE_KEYS
          reservation_hash['expected_pay_amount'] = value
        when *TOTAL_PAID_AMOUNT_ACCURATE_PROBABLE_KEYS
          reservation_hash['total_paid_amount_accurate'] = value
        when *PHONE_NUMBER_PROBABLE_KEYS
          value = [value] unless value.is_a?(Array)
          value.each do |number|
            phone_numbers[:reservation_contacts_attributes] <<= { 'number' => number }
          end
        end

        break if keys_checker.call && phone_numbers[:reservation_contacts_attributes].any?
      end
    end
    
    reservation_hash.merge!(phone_numbers) if phone_numbers[:reservation_contacts_attributes].any?
    [user_hash, reservation_hash]
  end
end
