class AsLabel < ActiveRecord::Base
  has_many :as_values, :dependent => :destroy
  belongs_to :as_note

  validates_presence_of :name
  validates_length_of :name, :maximum => 50

  def destroy_all_releated_data(as_label)
    transaction do
      AsValue.delete_all(["as_label_id=?",as_label])
      as_label.delete
    end
  end
end
