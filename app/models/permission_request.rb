class PermissionRequest < ActiveRecord::Base
  belongs_to :as_note
  belongs_to :user
end
