class PagesController < ApplicationController
  include PagesHelper
  protect_from_forgery
  before_filter :authenticate_admin_user!, except: :show

  def show
    path  = params[:path]
    @page = Page.find_by_path(path)

    render action: template_path(path)
  end

  def update
    @page = Page.find_or_create_by_path(params[:path])
    @page.update_attributes content: format_content(params[:content])

    render text: ''
  end
end
