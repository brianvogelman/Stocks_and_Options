class StocksController < ApplicationController
	
	def index

	end


	def show
		@stock_symbol =  params[:stock_symbol]
		@upper_limit = params[:upper_limit]
		@lower_limit = params[:lower_limit]
		stock_info = Unirest.get("https://sandbox.tradier.com/v1/markets/quotes?symbols=#{@stock_symbol}", headers:{"Accept" => "application/json", "Authorization" => "Bearer qAUHez0or2BAlrF7d4AsGlzn1hbv"}).body
		
		option_expiration = Unirest.get "https://sandbox.tradier.com/v1/markets/options/expirations?symbol=#{@stock_symbol}", headers:{"Accept" => "application/json", "Authorization" => "Bearer qAUHez0or2BAlrF7d4AsGlzn1hbv"}
		option_strike = Unirest.get "https://sandbox.tradier.com/v1/markets/options/strikes?symbol=#@stock_symbol}&#{option_expiration}", headers:{"Accept" => "application/json", "Authorization" => "Bearer qAUHez0or2BAlrF7d4AsGlzn1hbv"}
		option_chain = Unirest.get "https://sandbox.tradier.com/v1/markets/options/chains?symbol=#{@stock_symbol}&#{option_expiration}", headers:{"Accept" => "application/json", "Authorization" => "Bearer qAUHez0or2BAlrF7d4AsGlzn1hbv"}


		# if @quote["volume"] < @upper_limit && @quote["volume"] > @lower_limit
		# redirect_to "/stocks/1"
		# end
	end

end