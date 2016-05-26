Spree::Taxon.class_eval do

    has_many :greetings, through: :classifications
   
    def applicable_filter
      fs = []
      # fs << GreetingFilters.taxons_below(self)
      ## unless it's a root taxon? left open for demo purposes

      fs << Spree::Core::GreetingFilters.price_filter if Spree::Core::GreetingFilters.respond_to?(:price_filter)
      fs << Spree::Core::GreetingFilters.brand_filter if Spree::Core::GreetingFilters.respond_to?(:brand_filter)
      fs
    end

    def active_greetings
      greetings.active
    end

end
