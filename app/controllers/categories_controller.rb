class CategoriesController < ApplicationController

  respond_to :json
  respond_to :js, only: :menu

  def index
    # ["Can"]
    # => [
    #   ["Canon", "Sony", "Vestel", "Volkswagen"]
    # ]

    # ["Canon"]
    # => [
    #   ["Canon", "Sony", "Vestel", "Volkswagen"],
    #   ["Fotograf Makineleri", "Yazicilar", "Kameralar"]
    # ]

    # ["Canon", "Foto"]
    # => [
    #   ["Canon", "Sony", "Vestel", "Volkswagen"],
    #   ["Fotograf Makineleri", "Yazicilar", "Kameralar"]
    # ]

    # ["Canon", "Fotoğraf Makineleri"]
    # => [
    #   ["Canon", "Sony", "Vestel", "Volkswagen"],
    #   ["Fotograf Makineleri", "Yazicilar", "Kameralar"],
    #   ["SLR Makineler", "Amator Makineler"]
    # ]

    # ["Canon", "Fotoğraf Makineleri", "SLR Makineler"]
    # => [
    #   ["Canon", "Sony", "Vestel", "Volkswagen"],
    #   ["Fotograf Makineleri", "Yazicilar", "Kameralar"],
    #   ["SLR Makineler", "Amator Makineler"]
    # ]

    categories = []
    category_list = [Category.roots.pluck(:name)]

    terms = (params[:terms] || []).select { |term| term.present? }

    if first_term = terms.shift
      if (root_category = Category.find_by(name: first_term)) && root_category.try(:root?)
        category_list << root_category.children.pluck(:name)
        categories << root_category if root_category
      end
    end

    if root_category.try(:root?)
      terms.each_with_index do |term, i|
        if cat = categories[i].children.find_by(name: term)
          categories << cat
          category_list << categories[i+1].children.pluck(:name)
        else
          break
        end
      end
    end

    render json: category_list
  end

  def menu
    category = Category.find params[:id]
    @product = Product.find params[:product_id]

    @categories = category.menu

    @product_siblings = category.products

    respond_with(@categories)
  end
end
