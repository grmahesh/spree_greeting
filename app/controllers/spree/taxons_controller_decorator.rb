Spree::TaxonsController.class_eval do
    
	  helper 'spree/greetings'
	  
    def show
      @taxon = Taxon.friendly.find(params[:id])
      return unless @taxon

      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
      @products = @searcher.retrieve_products
	  @greetings = @searcher.retrieve_greetings
      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end
end
