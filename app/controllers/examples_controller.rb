class ExamplesController < ApplicationController
  helper_method :table_options
  before_action :authenticate_user!

  def index
    page = params[:page].to_i rescue nil
    @page_title = "Examples - #{@site_name}"
    @examples = Example.order('id DESC').page(page).load
  end

  def new
    @page_title = "New Example - #{@site_name}"
    @example = Example.new
    @tag_i18ns = TagI18n.all.load
  end

  def create
    @page_title = "New Example - #{@site_name}"
    @example = current_user.examples.build(example_params)
    @tag_i18ns = TagI18n.all.load
    render action: 'new' and return if not @example.save
    flash[:notice] = 'The example has been added successfully.'
    redirect_to examples_path
  end

  def edit
    @page_title = "Edit example『#{example_id}』- #{@site_name}"
    @example = Example.includes(:comments).find(example_id)
    @tag_i18ns = TagI18n.all.load
  end

  def update
    @page_title = "Edit example『#{example_id}』- #{@site_name}"
    @example = Example.find(example_id)
    @tag_i18ns = TagI18n.all.load
    redirect_to_index_if_not_permitted(@example)
    return if performed?
    render action: 'edit', id: example_id and return if not @example.update(example_params)
    flash[:notice] = 'The example has been updated successfully.'
    redirect_to examples_path
  end

  def destroy
    @example = Example.find(example_id)
    @example.destroy
    redirect_to_index_if_not_permitted(@example)
    return if performed?
    flash[:notice] = 'The example have been deleted successfully.'
    redirect_to examples_path
  end

  def backup
    @page_title = "Backup Examples - #{@site_name}"
  end

  def import
    table_name = params[:table_name]
    attachment = params[:attachment]
    items = JSON.parse(attachment.read)
    destroy_all = request.POST[:destroy_all]

    case table_name
    when 'examples'
      ActiveRecord::Base.transaction do
        Example.destroy_all if destroy_all

        items.each do |item|
          id = item['id']
          user_id = item['user_id']
          type_id = item['type_id']
          text = item['text']
          verified = item['verified'] || false

          example = Example.create!(id: id,
                                    user_id: user_id,
                                    type_id: type_id,
                                    text: text,
                                    verified: verified)
        end
      end
    when 'comments'
      ActiveRecord::Base.transaction do
        Comment.destroy_all if destroy_all

        items.each do |item|
          example_id = item['example_id']
          matchtext = item['matchtext']
          aliastext = item['aliastext']
          transtext = item['transtext']

          comment = Comment.create!(example_id: example_id,
                                    matchtext: matchtext,
                                    aliastext: aliastext,
                                    transtext: transtext)
        end
      end
    end

    redirect_to examples_backup_path
  end

  def export
    items = []

    table_name = params[:table_name]

    case table_name
    when 'examples'
      examples = Example.order('id ASC')
      examples.each do |example|
        items << {user_id: example.user_id,
                  type_id: example.type_id,
                  text: example.text,
                  verified: example.verified}
      end
    when 'comments'
      comments = Comment.order('id ASC')
      comments.each do |comment|
        items << {example_id: comment.example_id,
                  matchtext: comment.matchtext,
                  aliastext: comment.aliastext,
                  transtext: comment.transtext}
      end
    end

    send_data JSON.pretty_generate(items), filename: "#{table_name}.json"
  end

  def table_options
    ['examples', 'comments']
  end

  private

  def example_id
    params[:id]
  end

  def example_params
    params.require(:example).permit(:text, :verified, comments_attributes: [:id, :matchtext, :aliastext, :transtext, :_destroy],
                                                      tags_attributes: [:id, :tag_i18n_id, :_destroy])
  end

  def redirect_to_index_if_not_permitted(example)
    if not example.editable?(current_user)
      flash[:alert] = 'Access Denied.'
      redirect_to examples_path and return
    end
  end
end
