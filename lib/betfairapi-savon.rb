class BetfairAPI

  require 'savon'

  ##################################
  ## General API Services Reference
  ##################################
  # In a IRB console
  # require 'rubygems'
  # require 'betfairapi-savon'	
  # api = BetfairAPI.new
      
  # login = api.login('username', 'password', 82, 0, 0, nil)
  # login = login.to_hash[:login_response]
  # session_token = login[:result][:header][:session_token]  
  def login(username, password, product_id, vendor_software_id, location_id, ip_address)
    global.request :bf, :login do 
      soap.body = { 'bf:request' => { :username => username, :password => password, :productId => product_id, :vendorSoftwareId => vendor_software_id, :locationId => location_id, :ipAddress => ip_address } }
    end
  end
  
  # keep_alive = api.keep_alive(session_token)
  # keep_alive.to_hash[:keep_alive_response]
  def keep_alive(session_token)
    global.request :bf, :keepAlive do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token) } }
    end
  end
  
  # logout = api.logout(session_token)
  # logout.to_hash[:logout_response]
  def logout(session_token)
    global.request :bf, :logout do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token) } }
    end
  end

  ############################################
  ## Read Only Betting API Services Reference
  ############################################    
  
  # SERVICE_NOT_AVAILABLE_IN_PRODUCT
  # conversion = api.convert_currency(session_token, 20.00, 'AUD', 'UK')
  # conversion.to_hash[:convert_currency_response]
  def convert_currency(session_token, amount, from_currency, to_currency)
    global.request :bf, :convertCurrency do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token), :amount => amount, :fromCurrency => from_currency, :toCurrency => to_currency } }
    end
  end
  
  # SERVICE_NOT_AVAILABLE_IN_PRODUCT
  # active_event_types = api.get_active_event_types(session_token)
  # active_event_types.to_hash[:get_active_event_types_response]
  def get_active_event_types(session_token, locale = nil)
    global.request :bf, :getActiveEventTypes do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token), :locale => locale } }
    end	
  end
  
  # SERVICE_NOT_AVAILABLE_IN_PRODUCT
  # all_currencies = api.get_all_currencies(session_token)
  # all_currencies.to_hash[:get_all_currencies_response]
  def get_all_currencies(session_token)
    global.request :bf, :getAllCurrencies do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token) } }
    end
  end

  # SERVICE_NOT_AVAILABLE_IN_PRODUCT
  # all_currencies = api.get_all_currenciesV2(session_token)
  # all_currencies.to_hash[:get_all_currencies_v2_response]
  def get_all_currenciesV2(session_token)
    global.request :bf, :getAllCurrenciesV2 do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token) } }
    end	
  end
  
  # all_event_types = api.get_all_event_types(session_token)
  # all_event_types.to_hash[:get_all_event_types_response]
  def get_all_event_types(session_token, locale = nil)
    global.request :bf, :getAllEventTypes do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token), :locale => locale } }
    end
  end

  # markets = api.get_all_markets(session_token, 1, nil, [1,3], nil, nil, nil)
  # markets.to_hash[:get_all_markets_response]
  # markets.to_hash[:get_all_markets_response][:result][:market_data].split(':').each do |market|
  #		puts '------------------------'
  # 	puts market.to_s.split('~')
  # end
  def get_all_markets(session_token, exchange_id, locale = nil, event_type_ids = nil, countries = nil, from_date = nil, to_date = nil)
    exchange(exchange_id).request :bf, :getAllMarkets do
      soap.body = { 'bf:request' => { :header => api_request_header(session_token),  :locale => locale, :eventTypeIds => event_type_ids, :countries => nil, :fromDate => from_date, :toDate => to_date } }
    end
  end

  def get_bet
    raise 'See get bet lite'	
  end

  def get_bet_history
    raise 'To Do'
  end

  def get_bet_lite(session_token, exchange_id, bet_id)
		exchange(exchange_id).request :bf, :getBetLite do
			soap.body = { 'bf:request' => { :header => api_request_header(session_token), :betId => bet_id } }
		end
	end

  def get_bet_matches_lite
    raise 'To Do'
  end
  
  # complete_market_prices_compressed = api.get_complete_market_prices_compressed(session_token, 1, nil, 102458421)
  # complete_market_prices_compressed.to_hash[:get_complete_market_prices_compressed_response]
  def get_complete_market_prices_compressed(session_token, exchange_id, currency_code, market_id)
    exchange(exchange_id).request :bf, :get_complete_market_prices_compressed do
      soap.body = { 'bf:request' => { :header => api_request_header(session_token), :currencyCode => currency_code, :marketId => market_id } }
    end
  end

  def get_current_bets
    raise 'To Do'
  end

  def get_current_bets_lite
    raise 'To Do'
  end

  def get_detail_available_market_depth
    raise 'To Do'
  end

  def get_events
    raise 'To Do'
  end

  def get_in_play_markets
    raise 'To Do'
  end

  # market = api.get_market(session_token, 1, 102458421)
  # market.to_hash[:get_market_response]
	def get_market(session_token, exchange_id, market_id)
		exchange(exchange_id).request :bf, :getMarket do
			soap.body = { 'bf:request' => { :header => api_request_header(session_token), :marketId => market_id } }
		end
	end
	
  def get_market_info
    raise 'To Do'
  end
  
  # market_prices = api.get_market_prices(session_token, 1, nil, 102458421)
  # market_prices.to_hash[:get_market_prices_response]
  def get_market_prices(session_token, exchange_id, currency_code, market_id)
    exchange(exchange_id).request :bf, :getMarketPrices do
      soap.body = { 'bf:request' => { :header => api_request_header(session_token),  :currencyCode => currency_code, :marketId => market_id } }
    end
  end
  
  # market_prices_compressed = api.get_market_prices_compressed(session_token, 1, nil, 102458421)
  # market_prices_compressed.to_hash[:get_market_prices_compressed_response]
  def get_market_prices_compressed(session_token, exchange_id, currency_code, market_id)
    exchange(exchange_id).request :bf, :getMarketPricesCompressed do
     soap.body = { 'bf:request' => { :header => api_request_header(session_token),  :currencyCode => currency_code, :marketId => market_id } }
    end
  end

  def get_macthed_and_unmatched_bets
    raise 'To Do'
  end
  
  def get_mu_bets
		raise 'To Do'
	end

  def get_macthed_and_unmatched_bets_lite
    raise 'To Do'
  end
  
  def get_profit_and_loss
    raise 'To Do'
  end

  def get_market_traded_volume
    raise 'To Do'
  end

  def get_market_traded_volume_compressed
    raise 'To Do'
  end

  def get_private_markets
    raise 'To Do'
  end

  def get_silks
    raise 'To Do'
  end

  def get_silksV2
    raise 'To Do'
  end

  ############################################
  ## Bet Placement API Services Reference
  ############################################

  def cancel_bets	
		raise 'To Do'
	end

  def cancel_bets_by_market
    raise 'To Do'
  end

  def place_bet
		raise 'To Do'
	end

  def update_bets
    raise 'To Do'
  end

  ############################################
  ## Account Management Services Reference
  ############################################

  def add_payment_card
    raise 'To Do'
  end		

  def delete_payment_card
    raise 'To Do'
  end

  def deposit_from_payment_card
    raise 'To Do'
  end

  def forgot_password
    raise 'To Do'
  end

  def get_account_funds
    raise 'To Do'
  end

  def get_account_statement
    raise 'To Do'
  end

  def get_payment_card
    raise 'To Do'
  end

  def get_subscription_info
    raise 'To Do'
  end

  def modify_password
    raise 'To Do'
  end

  def modify_profile
    raise 'To Do'
  end

  def retrieve_limb_message
    raise 'To Do'
  end

  def self_exlude
    raise 'To Do'
  end

  def set_chat_name
    raise 'To Do'
  end

  def submit_limb_message
    raise 'To Do'
  end

  def transfer_funds
    raise 'To Do'
  end

  def update_payment_card
    raise 'To Do'
  end

  def view_profile
    raise 'To Do'
  end

  def view_profileV2
    raise 'To Do'
  end

  def view_refer_and_earn
    raise 'To Do'
  end

  def withdraw_to_payment_card
    raise 'To Do'
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

  def exchange(exchange_id = nil)
    exchange = Savon::Client.new do
      if exchange_id == 2
        wsdl.endpoint = 'https://api-au.betfair.com/exchange/v5/BFExchangeService'
        wsdl.namespace = 'http://www.betfair.com/exchange/v3/BFExchangeService/AUS' 
      else
        wsdl.endpoint = 'https://api.betfair.com/exchange/v5/BFExchangeService'
        wsdl.namespace = 'http://www.betfair.com/exchange/v3/BFExchangeService/UK'
      end
    end
  end

  def api_request_header(session_token)
    { :client_stamp => 0, :session_token => session_token }
  end

end
