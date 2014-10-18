require "#{Rails.root}/lib/file_size_validator" 

class Post < ActiveRecord::Base
  belongs_to :user

  # Mount Uploader
   mount_uploader :photon, PhotonUploader

  # Validate fields
  validates :user_id, presence: true

  
  # validate Carrierwave attachment
  # Set Max file limit to 32 MB
  validates :photon, 
			:presence => true, 
			  :file_size => { 
			      :maximum => 10.megabytes.to_i 
			    }

end
