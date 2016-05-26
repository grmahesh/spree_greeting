Spree::Admin::SearchController.class_eval do
      
	def greetings
        if params[:ids]
          @greetings = Greeting.where(id: params[:ids].split(",").flatten)
        else
          @greetings = Greeting.ransack(params[:q]).result
        end

        @greetings = @greetings.distinct.page(params[:page]).per(params[:per_page])
        expires_in 15.minutes, public: true
        headers['Surrogate-Control'] = "max-age=#{15.minutes}"
      end
end

