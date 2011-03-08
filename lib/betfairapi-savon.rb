class BetfairAPI
	
	require 'rubygems'
	require 'savon'

	##################################
	## General API Services Reference
	##################################
	# In a IRB console
	# require 'rubygems'
	# require 'betfairapi-savon'	
	# api = BetfairAPI.new
	# response = api.login('username', 'password', 82, 0, 0, nil)
	# session_token = response.to_hash[:login_response][:result][:header][:session_token]
	# api.keep_alive(session_token)
	# api.logout(session_token)
	
	def login(username, password, product_id, vendor_software_id, location_id, ip_address = nil)
		global.request :bf, :login do 
			soap.body = {'bf:request' => {:username => username, :password => password, :productId => product_id, :vendorSoftwareId => vendor_software_id, :locationId => location_id, :ipAddress => ip_address}}
		end
		global.to_hash
	end
	
	def keep_alive(session_token)
		global.request :bf, :keep_alive do 
			soap.body = {'bf:request' => { :header => api_request_header(session_token)}}
		end
		global.to_hash
	end
	
	def logout(session_token)
		global.request :bf, :logout do 
			soap.body = {'bf:request' => { :header => api_request_header(session_token)}}
		end
		global.to_hash
	end
	
	############################################
	## Read Only Betting API Services Reference
	############################################    
	
	def convert_currency
		'TO DO'	
  end

	def get_active_event_types
		'TO DO'	
  end
	
	def get_all_currencies
		'TO DO'	
  end

	def get_all_currenciesV2
		'TO DO'	
  end

	def get_all_event_types
		'TO DO'	
  end

	# markets = api.get_all_markets(session_token, 'AUS')
	# markets.to_hash[:get_all_markets_response][:result][:market_data].split(':').each do |market|
	#		puts '------------------------'
	# 	puts market.to_s.split('~')
	# end
	def get_all_markets(session_token, exchange_id = nil)
		exchange(exchange_id).request :bf, :get_all_markets do
		  soap.body = {'bf:request' => { :header => api_request_header(session_token)}}
		end
		exchange.to_hash
	end
	
	def get_bet
		'TO DO'	
  end

	def get_bet_history
		'TO DO'
	end
	
	def get_bet_lite
		'TO DO'
	end
	
	def get_bet_matches_lite
		'TO DO'
	end
	
	def get_complete_market_prices_compressed
		'TO DO'
	end
	
	def get_current_bets
		'TO DO'
	end
	
	def get_current_bets_lite
		'TO DO'
	end
	
	def get_detail_available_market_depth
		'TO DO'
	end
			
	def get_events
		'TO DO'
	end
	
	def get_in_play_markets
		'TO DO'
	end
	
  def get_market
		'TO DO'
  end

	def get_market_info
		'TO DO'
	end
	
  def get_market_prices
		'TO DO'
  end
	
  def get_market_prices_compressed
		'TO DO'
  end

	def get_macthed_and_unmatched_bets
		'TO DO'
	end
	
	def get_macthed_and_unmatched_bets_lite
		'TO DO'
	end
	
	def get_profit_and_loss
		'TO DO'
	end
	
	def get_market_traded_volume
		'TO DO'
	end
	
	def get_market_traded_volume_compressed
		'TO DO'
	end
	
	def get_private_markets
		'TO DO'
	end
	
	def get_silks
		'TO DO'
	end
	
	def get_silksV2
		'TO DO'
	end
	
	############################################
	## Bet Placement API Services Reference
	############################################
	
	def cancel_bets
		'TO DO'
	end
	
	def cancel_bets_by_market
		'TO DO'
	end

	def place_bets
		'TO DO'
  end
			
	def update_bets
		'TO DO'
	end
	
	############################################
	## Account Management Services Reference
	############################################
	
	def add_payment_card
		'TO DO'
	end		
	
	def delete_payment_card
		'TO DO'
	end
	
	def deposit_from_payment_card
		'TO DO'
	end
	
	def forgot_password
		'TO DO'
	end
	
	def get_account_funds
		'TO DO'
	end
	
	def get_account_statement
		'TO DO'
	end
	
	def get_payment_card
		'TO DO'
	end
	
	def get_subscription_info
		'TO DO'
	end
	
	def modify_password
		'TO DO'
	end
	
	def modify_profile
		'TO DO'
	end
	
	def retrieve_limb_message
		'TO DO'
	end
	
	def self_exlude
		'TO DO'
	end
	
	def set_chat_name
		'TO DO'
	end
	
	def submit_limb_message
		'TO DO'
	end
	
	def transfer_funds
		'TO DO'
	end
	
	def update_payment_card
		'TO DO'
	end
	
	def view_profile
		'TO DO'
	end
	
	def view_profileV2
		'TO DO'
	end
			
	def view_refer_and_earn
		'TO DO'
	end
	
	def withdraw_to_payment_card
		'TO DO'
	end
	
	##################################
	## Class Specific Methods
	##################################
	def global	
		global = Savon::Client.new do
		  wsdl.endpoint = 'https://api.betfair.com/global/v3/BFGlobalService'
		  wsdl.namespace = 'https://www.betfair.com/global/v3/BFGlobalService'
		end
	end
	
	def exchange(exchange = nil)
		exchange = Savon::Client.new do
		  wsdl.endpoint = exchange.nil? ? 'https://api.betfair.com/exchange/v5/BFExchangeService' : 'https://api-au.betfair.com/exchange/v5/BFExchangeService'
		  wsdl.namespace = exchange.nil? ? 'http://www.betfair.com/exchange/v3/BFExchangeService/UK' : 'http://www.betfair.com/exchange/v3/BFExchangeService/AUS'
		end
	end
	
	def api_request_header(session_token)
		{ :client_stamp => 0, :session_token => session_token }
	end
	
end
