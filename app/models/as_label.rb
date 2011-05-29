class AsLabel < ActiveRecord::Base
  has_many :as_values, :dependent => :delete_all
  belongs_to :as_note

  validates_presence_of :name
  validates_length_of :name, :maximum => 50
end
