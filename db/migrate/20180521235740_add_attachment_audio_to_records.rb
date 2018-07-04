class AddAttachmentAudioToRecords < ActiveRecord::Migration[5.0]
  def self.up
    change_table :records do |t|
      t.attachment :audio
    end
  end

  def self.down
    remove_attachment :records, :audio
  end
end
