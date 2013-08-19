# This class maps a Yummly response to attributes on to a recipe object. Because the search and find API calls return
# recipe data slightly different structures, it also automatically rectifies these differences where possible.
#
# When a response attribute is an array, collections of related objects will be created for convenience. For example,
# the "images" attribute on the response maps to the #images method which returns a collection of Yummlly::Image
# objects.
module Yummly
  class Recipe

    attr_accessor :response

    def initialize(recipe_json)
      @response = recipe_json
    end

    # Nutrition attribute’s search parameter name.
    def attribute
      response["attribute"]
    end

    def attributes
      response["attributes"]
    end

    def attribution
      response["attribution"]
    end

    def description
      response["description"]
    end

    # @return [Yummly::Flavor] instance of a Yummly::Flavor object
    def flavor
      @flavor ||= Yummly::Flavor.new(response["flavors"])
    end

    # @return [String] the Yummly id for this recipe.
    def id
      response["id"]
    end

    # @return [Array] collection of Yummly::Image objects.
    def images
      @images ||= images_node.collect { |image| Yummly::Image.new(image) }
    end

    # @return [Array] collection of strings of ingredients.
    def ingredients
      response["ingredients"] || ingredient_lines
    end

    # @return [Array] collection of strings of ingredients.
    def ingredient_lines
      response["ingredientLines"]
    end

    # Returns the name of the recipe, automatically finding it using the correct response node.
    # @return [String] name of the recipe
    def name
      response["name"] || recipe_name
    end

    # @return [Integer] number of servings this recipe provides.
    def number_of_servings
      response["numberOfServings"]
    end

    # The nutritional composition of the recipe, in the form of a list of nutrients and their amounts, per serving. We
    # will return nutrition estimates only for those recipes where we are reasonably confident in their accuracy. These
    # are only estimates and you should be clear about that in what you tell your users.
    # @return [Array] collection of Yummly::NutritionEstimate objects.
    def nutrition_estimates
      @nutrition_estimates ||= response["nutritionEstimates"].collect { |ne| Yummly::NutritionEstimate.new(ne) }
    end

    def rating
      response["rating"]
    end

    def recipe_name
      response["recipeName"]
    end

    def total_time
      response["totalTime"]
    end

    def total_time_in_seconds
      response["totalTimeInSeconds"]
    end

    def thumbnail
      unless images.empty?
        images.first.small_url
      end
    end

    def source
      Yummly::Source.new(response["source"])
    end

    private

    # The search and find API calls populate different image attribute nodes in their respective responses. This method
    # determines which one has been populated and returns a populated node for the images collection method to use. This
    # allows the developer using this API to only use one method to access images.
    def images_node
      response["images"] || response["smallImageUrls"].collect { |url| {"hostedSmallUrl" => url} }
    end

  end
end