class Page < ActiveRecord::Base
  acts_as_tree
  has_paper_trail
  attr_accessible :title, :content, :parent_id, :parent, :permalink
  serialize       :content, Hash
  has_permalink   :title, scope: :parent_id

  class << self
    def find_by_path(path)
      return unless page = root

      page.walk(path) do |last, part|
        last.children.find_by_permalink(part) if last
      end
    end

    def find_or_create_by_path(path)
      page = root || Page.create(permalink: '')

      page.walk(path) do |last, part|
        last.children.find_or_create_by_permalink(part)
      end
    end
  end

  def path
    if parent
      Pathname.new(parent.path) + permalink
    else
      Pathname.new("/")
    end
  end

  def walk(path, &block)
    parts = Pathname.new(path.to_s).each_filename

    parts.reduce(self, &block)
  end
end
