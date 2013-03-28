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
    Page.update_content(params[:path], format_content(params[:content]))

    render text: ''
  end
end
