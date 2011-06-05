class AsNote < ActiveRecord::Base
  has_many :as_labels
  has_many :as_values

  def get_sorted_labels(note)
    note.as_labels
  end

  validates_presence_of :name
  validates_length_of :name, :maximum => 50
end
