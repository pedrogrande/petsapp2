class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, ProfilePictureUploader

  validates :first_name, :last_name, :street, :state, :suburb, :postcode, :country, :phone, presence: true

  geocoded_by :full_street_address
  after_validation :geocode

  def full_street_address
    [street, suburb, state, country].compact.join(',')
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  # extend FriendlyId
  # friendly_id :first_name, use: :slugged
end
