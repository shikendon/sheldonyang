module ExamplesHelper
  def render_example_edit_link(example)
    return if not example.editable?(current_user)
    link_to 'Edit', action: 'edit', id: example.id
  end

  def render_example_form(url)
    render partial: 'example_form', :locals => {url: url}
  end

  def render_example_form_comment_field(comments_form)
    render partial: 'example_form_comment_field', :locals => {comments_form: comments_form}
  end

  def render_example_form_comment_fields(f)
    render partial: 'example_form_comment_fields', :locals => {f: f}
  end

  def render_example_form_tag_field(tags_form)
    render partial: 'example_form_tag_field', :locals => {tags_form: tags_form}
  end

  def render_example_form_tag_fields(f)
    render partial: 'example_form_tag_fields', :locals => {f: f}
  end

  def render_example_verified_checkbox(f, example)
    return if not example.editable?(current_user)
    render partial: 'example_verified_checkbox', :locals => {f: f}
  end

  def render_example_operation_button(example)
    return if example.id.nil?
    render partial: 'example_operation_button', :locals => {example: example}
  end
end
