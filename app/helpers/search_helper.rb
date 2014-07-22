module SearchHelper
  def render_search_form
    render partial: 'search_form'
  end

  def render_search_result(examples)
    render partial: 'search_result', :locals => {examples: examples}
  end

  def render_search_tag_links
    render partial: 'search_tag_links'
  end

  def render_search_reference
    render partial: 'search_reference'
  end

  def render_example_edit_link(example)
    return if not example.editable?(current_user)
    link_to 'Edit', controller: 'examples', action: 'edit', id: example.id
  end
end
