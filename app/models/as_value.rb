class AsValue < ActiveRecord::Base
  belongs_to :as_label

  def self.save_entire_record(values)
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

  def self.current_value(numero,label_id)
    current_record = AsValue.first(:select=>"value",:conditions=>["numero=? and as_label_id=?",numero,label_id])
    if current_record then
      current_record.value
    else
      nil
    end
  end

  def self.update_entire_record(numero,values)
    AsValue.transaction do
      values.each do |value|
        @as_value = AsValue.first(:conditions=>["numero=? and as_label_id=?",numero,value[0]])
        @as_value.value = value[1]
        @as_value.save
      end
    end
  end

  def self.delete_entire_record(numero)
    AsValue.transaction do
      AsValue.delete_all(["numero=?",numero])
    end
  end
end
