class AsValue < ActiveRecord::Base
  belongs_to :as_label

  def self.get_sort_label_id(as_note,p_sort)
    default_sort = as_note.as_labels.where("default_sort is ?",true).first
    default_sort = default_sort.id if default_sort
    p_sort || default_sort
  end

  def self.get_label_selected_array(label_selected)
    case label_selected
    when nil
      @label_selected_array= ["No.","numero"]
    when "numero"
      @label_selected_array= ["No.","numero"]
    else
      @label_selected_array= (label_selected.nil?)? ["No.","numero"] : [AsLabel.find(label_selected),label_selected]
    end
  end

  def self.get_lvalues_all(as_note,sort,direction,label_selected,search)
    search_like = "%"+search.to_s+"%"
    case sort
    when nil
      case label_selected
      when nil
        @l_values_all = as_note.as_labels.first.as_values.order("numero desc")
      when "numero"
        @l_values_all = as_note.as_labels.first.as_values.where("numero like ?",search_like).order("numero desc")
      else
        @l_values_all = as_note.as_labels.find(label_selected).as_values.where("value like ?",search_like).order("numero desc")
      end
    when "numero"
      case label_selected
      when nil
        @l_values_all = as_note.as_labels.first.as_values.order("numero "+direction)
      when "numero"
        @l_values_all = as_note.as_labels.first.as_values.where("numero like ?",search_like).order("numero "+direction)
      else
        @l_values_all = as_note.as_labels.find(label_selected).as_values.where("value like ?",search_like).order("numero "+direction)
      end
    else
      case label_selected
      when nil
        @l_values_all = as_note.as_labels.find(sort).as_values.order("value "+direction)
      when "numero"
        @l_values_all = as_note.as_labels.find(sort).as_values.where("numero like ?",search_like).order("value "+direction)
      else
        @l_values_all = AsValue.joins("inner join as_values sort").where(["sort.numero=as_values.numero and as_values.as_label_id=? and sort.as_label_id=? and as_values.value like ?",label_selected,sort,search_like]).order("sort.value "+direction)
      end
    end

    return @l_values_all
 
  end

  def self.get_lvalues_and_count(as_note,sort,direction,label_selected,search,page_number)
    search_like = "%"+search.to_s+"%"
    case sort
    when nil
      case label_selected
      when nil
        @l_values_page = as_note.as_labels.first.as_values.order("numero desc").page(page_number).per(15)
        @records_count = as_note.as_labels.first.as_values.count
      when "numero"
        @l_values_page = as_note.as_labels.first.as_values.where("numero like ?",search_like).order("numero desc").page(page_number).per(15)
        @records_count = as_note.as_labels.first.as_values.where("numero like ?",search_like).count
      else
        @l_values_page = as_note.as_labels.find(label_selected).as_values.where("value like ?",search_like).order("numero desc").page(page_number).per(15)
        @records_count = as_note.as_labels.find(label_selected).as_values.where("value like ?",search_like).count
      end
    when "numero"
      case label_selected
      when nil
        @l_values_page = as_note.as_labels.first.as_values.order("numero "+direction).page(page_number).per(15)
        @records_count = as_note.as_labels.first.as_values.count
      when "numero"
        @l_values_page = as_note.as_labels.first.as_values.where("numero like ?",search_like).order("numero "+direction).page(page_number).per(15)
        @records_count = as_note.as_labels.first.as_values.where("numero like ?",search_like).count
      else
        @l_values_page = as_note.as_labels.find(label_selected).as_values.where("value like ?",search_like).order("numero "+direction).page(page_number).per(15)
        @records_count = as_note.as_labels.find(label_selected).as_values.where("value like ?",search_like).count
      end
    else
      case label_selected
      when nil
        @l_values_page = as_note.as_labels.find(sort).as_values.order("value "+direction).page(page_number).per(15)
        @records_count = as_note.as_labels.find(sort).as_values.count
      when "numero"
        @l_values_page = as_note.as_labels.find(sort).as_values.where("numero like ?",search_like).order("value "+direction).page(page_number).per(15)
        @records_count = as_note.as_labels.find(sort).as_values.where("numero like ?",search_like).count
      else
        @l_values_page = AsValue.joins("inner join as_values sort").where(["sort.numero=as_values.numero and as_values.as_label_id=? and sort.as_label_id=? and as_values.value like ?",label_selected,sort,search_like]).order("sort.value "+direction).page(page_number).per(15)
        @records_count = AsValue.joins("inner join as_values sort").where(["sort.numero=as_values.numero and as_values.as_label_id=? and sort.as_label_id=? and as_values.value like ?",label_selected,sort,search_like]).count
      end
    end

    return @l_values_page, @records_count
  end

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
        if @as_value then
          @as_value.value = value[1]
        else
          @as_value = AsValue.new
          @as_value.numero = numero
          @as_value.as_label_id = value[0]
          @as_value.value = value[1]
        end
        @as_value.save
      end
    end
  end

  def self.delete_entire_record(numero)
    AsValue.transaction do
      AsValue.delete_all(["numero=?",numero])
    end
  end

  def self.get_record_created_date(labels,numero)
    created_at = labels.first.as_values.find_by_numero(numero).created_at
    labels.each do |lb|
      created_at = (created_at <= lb.as_values.find_by_numero(numero).created_at)? created_at : lb.as_values.find_by_numero(numero).created_at
    end
    created_date = created_at.strftime("%Y-%m-%d")
  end

  def self.get_record_updated_date(labels,numero)
    updated_at = labels.first.as_values.find_by_numero(numero).updated_at
    labels.each do |lb|
      updated_at = (updated_at >= lb.as_values.find_by_numero(numero).updated_at)? updated_at : lb.as_values.find_by_numero(numero).updated_at
    end
    updated_date = updated_at.strftime("%Y-%m-%d")
  end

end
