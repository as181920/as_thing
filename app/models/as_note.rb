class AsNote < ActiveRecord::Base
  #acts_as_list :scope => :ownership
  has_many :relationships, :foreign_key => "fd_note_id"
  has_many :followers, :through => :relationships, :source => :follower

  has_many :ownerships
  has_many :owners, :through => :ownerships, :source => :user

  has_many :permission_requests, :dependent => :destroy
  has_many :appliers, :through => :permission_requests, :source=>:user, :foreign_key => "user_id"

  has_many :as_labels, :dependent => :destroy
  has_many :as_values, :through => :as_labels

  validates_presence_of :name
  validates_length_of :name, :maximum => 50

  def self.public_notes
    AsNote.where("public=?",true)
  end

  def get_created_date(note)
    note.created_at.strftime("%Y-%m-%d")
  end

  def get_updated_date(note)
    if note.as_labels.first and note.as_labels.first.as_values.order("updated_at DESC").first then
      updated_at = note.as_labels.first.as_values.order("updated_at DESC").first.updated_at
      note.as_labels.each do |lb|
        if lb.as_values.order("updated_at DESC").first then
          updated_at = (updated_at > lb.as_values.order("updated_at DESC").first.updated_at)? updated_at : lb.as_values.order("updated_at DESC").first.updated_at
        end
      end
      updated_date = updated_at.strftime("%Y-%m-%d")
    else
      ""
    end
  end

  def get_sorted_labels(note)
    #note.as_labels
    note.as_labels.order("position asc")
  end

  def get_visible_labels(note)
    note.as_labels.where(["invisible = ?",false]).order("position asc")
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
