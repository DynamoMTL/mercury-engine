module PagesHelper
  SIMPLE_TAGS = %w(h1 h2 h3 h4 h5 h6 a span label)

  def format_content(content)
    content.reduce({}) do |hash, (key, data)|
      hash[key.to_s] = data[:value] || data[:attributes][:src]
      hash
    end
  end

  def editable(id, tag=:div, options={}, &block)
    content        = content_for(id)
    type           = options[:type] || find_type_for_tag(tag)
    options[:id]   = id

    if params[:mercury_frame]
      options[:data] ||= {}
      options[:data][:mercury] = type
    end

    if type == :simple 
      if content
        content_tag(tag, content, options.except(:type))
      else
        content_tag(tag, options.except(:type), &block)
      end
    else
      content_tag(tag, options.except(:type), false) do
        raw(content || (block.call if block))
      end
    end
  end

  def editable_image(id, default=nil)
    source  = content_for(id) || default
    options = {id: id, data: {mercury: :image}}

    image_tag(source, options)
  end

  def title
    editable(:h1, :title, @page.content[:title])
  end

  def content_for(id)
    @page.content[id.to_s] if @page
  end

  def find_type_for_tag(tag)
    if SIMPLE_TAGS.include?(tag.to_s)
      :simple
    else
      :full
    end
  end
end
