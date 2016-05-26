Spree::Admin::OptionTypesController.class_eval do
     
      def update_values_positions
        ActiveRecord::Base.transaction do
          params[:positions].each do |id, index|
            Spree::OptionValue.where(id: id).update_all(position: index)
          end
        end

        respond_to do |format|
          format.html { redirect_to admin_product_variants_url(params[:product_id]) }
		  format.html { redirect_to admin_greeting_variants_url(params[:greetingcard_id]) }
          format.js { render text: 'Ok' }
        end
      end

end
