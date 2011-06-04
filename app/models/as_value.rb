class AsValue < ActiveRecord::Base
  belongs_to :as_label

  def self.save_entire_record(values,as_note)
    last_value = AsValue.first(:select=>:numero,:order=>"numero DESC")
    if last_value then
      numero = last_value.numero + 1
    else
      numero = 0
    end

    AsValue.transaction do
      values.each do |value|
        @as_value = AsValue.new
        @as_value.numero = numero
        @as_value.as_label_id = value[0]
        @as_value.value = value[1]
        @as_value.save
      end
    end
  end
end
