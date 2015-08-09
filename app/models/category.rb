class Category < ActiveRecord::Base
  has_ancestry

  has_many :products

  def menu
    @menu ||= [].tap do |menu|
      ancestry_categories = ancestors.map do |ancestor|
       [ancestor, ancestor.siblings.to_a]
      end

      menu.concat(ancestry_categories)

      menu << [self, siblings.to_a]

      menu << [Struct.new(:name).new(I18n.t('common.choose')), children.to_a] if children.exists?
    end
  end
end
