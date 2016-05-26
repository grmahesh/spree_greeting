Spree::OrdersHelper.class_eval do
   
	def truncated_greeting_description(greeting)
		truncate_html(raw(greeting.name))
    end

end
