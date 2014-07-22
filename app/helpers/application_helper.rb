module ApplicationHelper
  # %F - The ISO 8601 date format (%Y-%m-%d)
  # %R - 24-hour time (%H:%M)
  # %T - 24-hour time (%H:%M:%S)
  def date_tag(date_or_time)
    return nil if date_or_time.nil?
    time_tag date_or_time, format: '%F'
  end

  def datetime_tag(date_or_time)
    return nil if date_or_time.nil?
    time_tag date_or_time, format: '%F %R'
  end

  def current_page?(link_path)
    current_path = url_for(controller: controller_name, action: action_name)
    link_path == '/' ? current_path == link_path : current_path.start_with?(link_path)
  end

  def render_error_message(object)
    content_tag(:p, object.errors.full_messages.join(', '), class: 'alert alert-danger') if object.errors.any?
  end

  def render_navbar_list
    render partial: 'partials/navbar_list'
  end

  def render_navbar_list_private
    render partial: 'partials/navbar_list_private'
  end

  def render_pagination(object)
    paginate object
  end

  def render_field_template(f, association)
    object_name = f.object.class.name.downcase
    association_name = association.to_s.singularize
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |field_form_builder|
      render partial: "#{object_name}_form_#{association_name}_field_template", :locals => {field_form_builder: field_form_builder}
    end
  end
end
