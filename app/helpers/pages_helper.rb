module PagesHelper
  def format_content(content)
    content.reduce({}) do |hash, (key, data)|
      hash[key.to_sym] = data[:value] || data[:attributes][:src]
      hash
    end
  end

  def editable(tag, id, default=nil, style=:full, &block)
    value   = content(id, default)
    escaped = style == :full ? raw(value) : value
    options = {id: id, data: {mercury: style}}
    block   = nil unless escaped.blank?

    content_tag(tag, escaped, options, &block)
  end

  def editable_image(id, default=nil)
    source  = content(id, default)
    options = {id: id, data: {mercury: :image}}

    image_tag(source, options)
  end

  def title
    editable(:h1, :title, @page.content[:title], :simple)
  end

  def content(id, default=nil)
    @page.content[id] || default
  end
end
