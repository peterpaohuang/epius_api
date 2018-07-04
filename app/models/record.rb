class Record < ApplicationRecord
  belongs_to :user
  has_attached_file :audio
  validates_attachment_content_type :audio, :content_type => ['audio/m4a']
end
