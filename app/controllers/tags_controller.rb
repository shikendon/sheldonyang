class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = "Tags - #{@site_name}"
    @tag_i18ns = TagI18n.all.load
  end

  def new
    @page_title = "New Tag - #{@site_name}"
    @tag_i18n = TagI18n.new
  end

  def create
    @tag_i18n = TagI18n.new(tag_i18n_params)
    render 'new' and return if not @tag_i18n.save
    redirect_to tags_path
  end

  def edit
    @page_title = "Edit Tag - #{@site_name}"
    @tag_i18n = TagI18n.find(tag_i18n_id)
  end

  def update
    @tag_i18n = TagI18n.find(tag_i18n_id)
    render 'edit' and return if not @tag_i18n.update(tag_i18n_params)
    redirect_to tags_path(@tag_i18n)
  end

  def destroy
    @tag_i18n = TagI18n.find(tag_i18n_id)
    @tag_i18n.destroy
    redirect_to tags_path
  end

  private

  def tag_i18n_id
    params[:id]
  end

  def tag_i18n_params
    params.require(:tag_i18n).permit(:id, :name, :_destroy)
  end
end
