class AsNote < ActiveRecord::Base
  has_many :as_labels, :dependent => :destroy

  validates_presence_of :name
  validates_length_of :name, :maximum => 50

  def get_sorted_labels(note)
    note.as_labels
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
