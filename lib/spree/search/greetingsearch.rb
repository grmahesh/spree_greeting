module Spree::Search
	class Greeting < Spree::Core::Search::Base

	def retrieve_greetings
		@greetings = get_base_scop
          curr_page = page || 1

          unless Spree::Config.show_greetings_without_price
            @greetings = @greetings.where("spree_prices.amount IS NOT NULL").
                                  where("spree_prices.currency" => current_currency)
          end
          @greetings = @greetings.page(curr_page).per(per_page)
    end
	
	 protected
          def get_base_scop
			base_scop = Spree::Greeting.spree_base_scopes.active
            base_scop = base_scop.in_taxon(taxon) unless taxon.blank?
			base_scop = get_greetings_conditions_for(base_scop, keywords)
            base_scop = add_search_scope(base_scop)
            base_scop = add_eagerload_scopes(base_scop)
            base_scop
          end
	
	      def add_search_scope(base_scop)
            search.each do |name, scope_attribute|
              scope_name = name.to_sym
              if base_scop.respond_to?(:search_scopes) && base_scop.search_scopes.include?(scope_name.to_sym)
                base_scop = base_scop.send(scope_name, *scope_attribute)
              else
				  base_scop = base_scop.merge(Spree::Greeeting.ransack({scope_name => scope_attribute}).result)
              end
            end if search.is_a?(Hash)
            base_scop
          end
	      
	      def get_greetings_conditions_for(base_scop, query)
            unless query.blank?
              base_scop = base_scop.like_any([:name, :description], query.split)
            end
            base_scop
          end
	end
end