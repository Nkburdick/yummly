module Yummly
  class Response

    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def attribution
      response['attribution'].symbolize_keys
    end

    def total_match_count
      response["totalMatchCount"]
    end

    def facet_counts
      response['facetCounts']
    end

    def recipes
      response["matches"].collect { |recipe_json| Yummly::Recipe.new(recipe_json) }
    end

    # Alias for recipes
    def matches
      recipes
    end

    def criteria
      response['criteria'].symbolize_keys
    end

  end  
end
