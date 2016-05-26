Spree::OrdersController.class_eval do
    
	helper 'spree/greetings'

    def show
		@order = Spree::Order.includes(line_items:[variant: ([:option_values, :images, :product] || [:option_values,:greeting])], bill_address: :state, ship_address: :state).find_by_number!(params[:id])
    end
	
    # Shows the current incomplete order from the session
    def edit
      @order = current_order || Sprr::Order.incomplete.
                                  includes(line_items: [variant: ([:option_values, :images, :product] || [:option_values,:greeting])]).
                                  find_or_initialize_by(guest_token: cookies.signed[:guest_token])
      associate_user
    end
	
end
