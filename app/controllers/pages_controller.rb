class PagesController < ApplicationController
  before_filter :find_page

  def show
    render action: @page.template_path
  end
=begin

  def update
    content = params[:content]
    @page.title = content[:title][:value]
    @page.content = Hash[content.map {|h,k| [h.to_sym, k[:value] || k[:attributes][:src] ]}]
    @page.save!
    render text: ''
  end
=end

private
  def find_page
    @page = Page.find_by_path!(params[:path])
  end
end
