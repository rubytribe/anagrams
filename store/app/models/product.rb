class Product < ActiveRecord::Base
  #belongs_to :user

  mount_uploader :image_url, PictureUploader

  validates :name, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :name, uniqueness: true, length: {minimum: 5,
                                              message: "too short. Must be at least 5 characters long." }
  validates :image_url,presence: true
  validate :image_size

  private

    def image_size
      if image_url.size > 5.megabytes
        errors.add(:image_url, "should be less than 5 MB")
      end
    end

  #, {message: "error. No file selected. Please choose a picture."}
  #validates :image_url, allow_blank:true, format: {with: %r{\.(gif|jpg|png)\Z}i, message: 'must be a URL for GIF, JPG or PNG image.' }
end
