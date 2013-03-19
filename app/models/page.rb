class Page < ActiveRecord::Base
  acts_as_tree
  attr_accessible :title, :content, :parent_id, :parent
  serialize :content, Hash
  has_permalink :title

  validates :title, presence: true
  validates :title, uniqueness: {scope: :parent_id}

  def self.find_by_path(path)
    parts = path.split('/').reject(&:blank?)
    page  = root

    while page && part = parts.shift
      page = page.children.find_by_permalink(part)
      return unless page
    end

    page
  end

  def self.find_by_path!(path)
    find_by_path(path) or raise ActiveRecord::RecordNotFound
  end

  def path
    if parent
      (Pathname.new(parent.path) + permalink).to_s
    else
      "/"
    end
  end
end
