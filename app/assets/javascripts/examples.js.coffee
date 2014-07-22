$(document).on 'click', '#button_new_comment', (event) ->
  raw_html = render_template('.template-example-comment-row', 'comments')
  $('[id^="new_example"] .comments_field, [id^="edit_example"] .comments_field').append(raw_html)

$(document).on 'click', '.tags_field a', (event) ->
  $self = $(event.currentTarget)
  $tags_field = $('[id^="new_example"] .tags_field, [id^="edit_example"] .tags_field')
  tag_i18n_id = $self.data('tag-i18n-id')

  if not ($tags_field.find("[name$=\"[tag_i18n_id]\"][value=\"#{tag_i18n_id}\"]").length > 0)
    raw_html = render_template('.template-example-tag', 'tags')
    createDocument = browserCompatibleDocumentParser()
    doc = createDocument(raw_html)
    doc.querySelector('[name$=\"[tag_i18n_id]\"]').setAttribute('value', tag_i18n_id)
    doc.querySelector('[id][name$=\"[_destroy]\"]').setAttribute('value', 'true')
    new_tag_field = doc.getElementsByTagName('body')[0]
    $tags_field.get(0).appendChild(new_tag_field)

  $input_tag_i18n_id = $tags_field.find("[name$=\"[tag_i18n_id]\"][value=\"#{tag_i18n_id}\"]")
  $input__destroy = $input_tag_i18n_id.next("[id][name$=\"[_destroy]\"]")
  if $input__destroy.attr('value') != 'false'
    $self.addClass('active')
    $input__destroy.attr('value', 'false')
  else
    $self.removeClass('active')
    $input__destroy.attr('value', 'true')

example_tag_fields_initialize = ->
  $tags_field = $('[id^="new_example"] .tags_field, [id^="edit_example"] .tags_field')
  $input_tag_i18n_ids = $tags_field.find("[name$=\"[tag_i18n_id]\"]")
  for input_tag_i18n_id in $input_tag_i18n_ids
    tag_i18n_id = $(input_tag_i18n_id).val()
    $anchor_item = $tags_field.find("[data-tag-i18n-id=\"#{tag_i18n_id}\"]")
    $anchor_item.addClass('active')

$(window).on 'load page:load', ->
  example_tag_fields_initialize()
