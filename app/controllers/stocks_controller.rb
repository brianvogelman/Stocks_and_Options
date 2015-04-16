class StocksController < ApplicationController
	
	def index

	end


	def show
		@stock_symbol =  params[:stock_symbol]
		@upper_limit = params[:upper_limit]
		@lower_limit = params[:lower_limit]
		@stock_info = Unirest.get("https://sandbox.tradier.com/v1/markets/quotes?symbols=#{@stock_symbol}", headers:{"Accept" => "application/json", "Authorization" => "Bearer qAUHez0or2BAlrF7d4AsGlzn1hbv"}).body
		
		

		@option_expiration = Unirest.get("https://sandbox.tradier.com/v1/markets/options/expirations?symbol=#{@stock_symbol}", headers:{"Accept" => "application/json", "Authorization" => "Bearer qAUHez0or2BAlrF7d4AsGlzn1hbv"}).body['expirations']['date'][0]
		@option_expiration.gsub!('-','').slice!(0..1)

		@option_strikes = Unirest.get("https://sandbox.tradier.com/v1/markets/options/strikes?symbol=#{@stock_symbol}&expiration=#{@option_expiration}", headers:{"Accept" => "application/json", "Authorization" => "Bearer qAUHez0or2BAlrF7d4AsGlzn1hbv"}).body['strikes']['strike']
		@option_infos = []
		@option_strikes.each do |option_strike|
			option_strike = (option_strike * 1000).to_i.to_s
			if option_strike.size == 3
				option_strike = "00000#{option_strike}"
			elsif option_strike.size == 4
				option_strike = "0000#{option_strike}"
			elsif option_strike.size == 5
				option_strike = "000#{option_strike}"
			elsif option_strike.size == 6
				option_strike = "00#{option_strike}"
			elsif option_strike.size == 7
				option_strike = "0#{option_strike}"
			end
			@option_symbol = params[:stock_symbol].upcase + @option_expiration + "C" + option_strike.to_s
			option_info = Unirest.get("https://sandbox.tradier.com/v1/markets/quotes?symbols=#{@option_symbol}", headers:{"Accept" => "application/json", "Authorization" => "Bearer qAUHez0or2BAlrF7d4AsGlzn1hbv"}).body
			@option_infos << option_info
		end
		puts @option_infos.inspect


		# @option_chain = Unirest.get "https://sandbox.tradier.com/v1/markets/options/chains?symbol=#{@stock_symbol}&#{option_expiration}", headers:{"Accept" => "application/json", "Authorization" => "Bearer qAUHez0or2BAlrF7d4AsGlzn1hbv"}


		# if @quote["volume"] < @upper_limit && @quote["volume"] > @lower_limit
		# redirect_to "/stocks/1"
		# end
	end

end