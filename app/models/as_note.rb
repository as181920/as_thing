class AsNote < ActiveRecord::Base
  has_many :as_labels, :dependent => :destroy
  has_many :ownerships
  has_many :users, :through => :ownerships

  validates_presence_of :name
  validates_length_of :name, :maximum => 50

  def self.public_notes
    AsNote.where("public=?",true)
  end

  def get_sorted_labels(note)
    note.as_labels
  end

  def get_visible_labels(note)
    note.as_labels.where(["invisible = ?",false])
  end

  def destroy_all_releated_data(as_note)
    transaction do
      as_note.as_labels.each do |as_label|
        AsValue.delete_all(["as_label_id=?",as_label])
      end
      AsLabel.delete_all(["as_note_id",as_note])
      as_note.delete
    end
  end
end
