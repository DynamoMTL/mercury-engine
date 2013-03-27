class Page < ActiveRecord::Base
  acts_as_tree
  has_paper_trail
  attr_accessible :title, :content, :parent_id, :parent, :permalink
  serialize       :content, Hash
  has_permalink   :title, scope: :parent_id

  validates :title, presence: true
  validates :title, uniqueness: {scope: :parent_id}

  class << self
    def find_by_path(path)
      return unless page = root

      parts = path.to_s.split('/').reject(&:blank?)

      parts.reduce(page) do |last_page, part|
        last_page.children.find_by_permalink(part) if last_page
      end
    end

    def find_by_path!(path)
      find_by_path(path) or raise ActiveRecord::RecordNotFound
    end

    def find_or_create_by_path(path)
      find_by_path(path) || Page.create(permalink: '')
    end
  end

  def root?
    !parent
  end

  def path
    if parent
      Pathname.new(parent.path) + permalink
    else
      Pathname.new("/")
    end
  end

  def template_path
    if children.present? || root?
      path + 'index'
    else
      path
    end.to_s
  end
end
