class Ownership < ActiveRecord::Base
  belongs_to :user
  belongs_to :as_note
end
