class Product < ActiveRecord::Base
  include Contentable
  include Imageable

  # Associations
  belongs_to :category

  # Validations
  validates_presence_of :title, :body

  def categories
    @categories ||= [].tap do |cats|
      if category
        cats.concat(category.ancestors.pluck(:name).map {|cat| { name: cat } })
        cats << { name: category.name }
      end
    end
  end

  def siblings
    Product.includes(:node).where(category: category)
  end

  def categories= categories_array
    categories = []

    categories_array = categories_array.select { |term| term["name"].present? }.map { |t| t["name"] }

    root_cat = Category.find_or_create_by name: categories_array.shift

    if root_cat and root_cat.root?
      categories << root_cat
    end

    categories_array.each_with_index do |term, index|
      categories << categories[index].children.find_or_create_by(name: term)    
    end

    if categories.last.has_children?
      errors.add :category, "It should take place at the end of the tree."
    end

    self.category = categories.last
  end

  def to_builder
    {
      title: title,
      tagList: node.tags.map(&:name),
      status: node.status || Node.workflow_spec.states.keys.first,
      bodyWidgets: JSON.parse(body_widgets),
      categories: categories
    }.to_json
  end

end