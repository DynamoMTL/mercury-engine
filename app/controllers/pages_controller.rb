class PagesController < ApplicationController
  include PagesHelper
  protect_from_forgery
  before_filter :authenticate_user!, except: :show
  before_filter :find_page

  def show
    render action: @page.template_path
  end

  def update
    @page.update_attributes content: format_content(params[:content])

    render text: ''
  end

private
  def find_page
    @page = Page.find_by_path!(params[:path])
  end
end
