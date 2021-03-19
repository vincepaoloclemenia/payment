class User < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.find_or_create_by!(hash)
    find_by_email(hash[:email] || hash['email']) || create!(hash)
  end
end
