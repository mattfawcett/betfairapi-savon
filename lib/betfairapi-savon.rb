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
    global.request :bf, :keep_alive do 
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
    global.request :bf, :convert_currency do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token), :amount => amount, :fromCurrency => from_currency, :toCurrency => to_currency } }
    end
  end
  
  # SERVICE_NOT_AVAILABLE_IN_PRODUCT
  # active_event_types = api.get_active_event_types(session_token, 'GBR')
  # active_event_types.to_hash[:get_active_event_types_response]
  def get_active_event_types(session_token, locale = nil)
    global.request :bf, :get_active_event_types do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token), :locale => locale } }
    end	
  end
  
  # SERVICE_NOT_AVAILABLE_IN_PRODUCT
  # all_currencies = api.get_all_currencies(session_token)
  # all_currencies.to_hash[:get_all_currencies_response]
  def get_all_currencies(session_token)
    global.request :bf, :get_all_currencies do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token) } }
    end
  end

  # SERVICE_NOT_AVAILABLE_IN_PRODUCT
  # all_currencies = api.get_all_currenciesV2(session_token)
  # all_currencies.to_hash[:get_all_currenciesV2_response]
  def get_all_currenciesV2(session_token)
    global.request :bf, :get_all_currenciesV2 do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token) } }
    end	
  end
  
  # all_event_types = api.get_all_event_types(session_token, 'AUS')
  # all_event_types.to_hash[:get_all_event_types_response]
  def get_all_event_types(session_token, locale = nil)
    global.request :bf, :get_all_event_types do 
      soap.body = { 'bf:request' => { :header => api_request_header(session_token), :locale => locale } }
    end
  end

  # markets = api.get_all_markets(session_token, nil, nil, [1,3], nil, nil, nil)
  # markets.to_hash[:get_all_markets_response]
  # markets.to_hash[:get_all_markets_response][:result][:market_data].split(':').each do |market|
  #		puts '------------------------'
  # 	puts market.to_s.split('~')
  # end
  def get_all_markets(session_token, exchange = nil, locale = nil, event_type_ids = nil, countries = nil, from_date = nil, to_date = nil)
    exchange(exchange).request :bf, :get_all_markets do
      soap.body = { 'bf:request' => { :header => api_request_header(session_token),  :locale => locale, :eventTypeIds => event_type_ids, :countries => nil, :fromDate => from_date, :toDate => to_date } }
    end
  end

  def get_bet
    raise 'To Do'	
  end

  def get_bet_history
    raise 'To Do'
  end

  def get_bet_lite
    raise 'To Do'
  end

  def get_bet_matches_lite
    raise 'To Do'
  end
  
  # complete_market_prices_compressed = api.get_complete_market_prices_compressed(session_token, nil, nil, 102448928)
  # complete_market_prices_compressed.to_hash[:complete_market_prices_compressed_response]
  def get_complete_market_prices_compressed(session_token, exchange = nil, currency_code = nil, market_id = nil)
    exchange(exchange).request :bf, :get_complete_market_prices_compressed do
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

  # market = api.get_market(session_token, nil, 12345, nil, nil)
  # market.to_hash[:get_markets_response]
  def get_market(session_token, exchange = nil, market_id = nil, include_coupon_links = nil, locale = nil)
    exchange(exchange).request :bf, :get_market do
      soap.body = { 'bf:request' => { :header => api_request_header(session_token),  :market_id => market_id, :includeCouponLinks => include_coupon_links, :locale => locale } }
    end
  end

  def get_market_info
    raise 'To Do'
  end
  
  # market_prices = api.get_market_prices(session_token, nil, nil, 102448928)
  # market_prices.to_hash[:get_market_prices_response]
  def get_market_prices(session_token, exchange = nil, currency_code = nil, market_id = nil)
   exchange(exchange).request :bf, :get_market_prices do
      soap.body = { 'bf:request' => { :header => api_request_header(session_token),  :currencyCode => currency_code, :market_id => market_id } }
    end
  end
  
  # market_prices_compressed = api.get_market_prices_compressed(session_token, nil, nil, 102448928)
  # market_prices_compressed.to_hash[:get_market_prices_compressed_response]
  def get_market_prices_compressed(session_token, exchange = nil, currency_code = nil, market_id = nil)
   exchange(exchange).request :bf, :get_market_prices_compressed do
      soap.body = { 'bf:request' => { :header => api_request_header(session_token),  :currencyCode => currency_code, :market_id => market_id } }
    end
  end

  def get_macthed_and_unmatched_bets
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

  def place_bets
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
