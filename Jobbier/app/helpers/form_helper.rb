module FormHelper

 #---------------------------------------------------------------
 def icon(name, html_options={})
   html_options[:class] = ['fa', "fa-#{name}", html_options[:class]].compact
   content_tag(:i, nil, html_options)
 end

  #---------------------------------------------------------------
  def order_url(field_name, filter_params={})
    filter_params = (filter_params.to_h || {}).dup
    filter_params[:order] = field_name
    filter_params[:direction] = (filter_params[:direction] == 'asc') ? 'desc' : 'asc'
    return {filter: filter_params}
  end

  #---------------------------------------------------------------
  def field_data(id, fields)
    {id: id, fields: fields.gsub("\n", "").gsub('"', "'")}
  end

  #---------------------------------------------------------------
  def from_filter?
    params[:filter].present? && !params[:filter].key?("direction") && !params[:filter].key?("order")
  end

  #---------------------------------------------------------------
  def link_to_add_workshop_image(form_builder, kind)
    new_object = WorkshopImage.new(kind: kind)
    kind_str = (kind.to_sym == :place)? '_place' : '_normal'
    id = new_object.object_id
    fields = form_builder.fields_for(:workshop_images, new_object, child_index: id) do |builder|
      render("workshop_image_fields", f: builder)
    end
    link_to '<i class="fa fa-plus fa-2x"></i>'.html_safe, '#', class: "btn add-workshop_image#{kind_str}", data: field_data(id, fields)
  end
  #---------------------------------------------------------------
  def link_to_add_workshop_schedule(form_builder)
    new_object = WorkshopSchedule.new
    id = new_object.object_id
    fields = form_builder.fields_for(:workshop_schedules, new_object, child_index: id) do |builder|
      render("workshop_schedule_fields", f: builder)
    end
    link_to '<i class="fa fa-plus"></i> Agregar calendario'.html_safe, '#', class: "add-workshop_schedule", data: field_data(id, fields)
  end

end
