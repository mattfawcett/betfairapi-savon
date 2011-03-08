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
  end

  def keep_alive(session_token)
    global.request :bf, :keep_alive do 
      soap.body = {'bf:request' => { :header => api_request_header(session_token)}}
    end
  end

  def logout(session_token)
    global.request :bf, :logout do 
      soap.body = {'bf:request' => { :header => api_request_header(session_token)}}
    end
  end

  ############################################
  ## Read Only Betting API Services Reference
  ############################################    

  def convert_currency
    raise 'To Do'	
  end

  def get_active_event_types
    raise 'To Do'	
  end

  def get_all_currencies
    raise 'To Do'	
  end

  def get_all_currenciesV2
    raise 'To Do'	
  end

  def get_all_event_types
    raise 'To Do'	
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

  def get_complete_market_prices_compressed
    raise 'To Do'
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

  def get_market
    raise 'To Do'
  end

  def get_market_info
    raise 'To Do'
  end

  def get_market_prices
    raise 'To Do'
  end

  def get_market_prices_compressed
    raise 'To Do'
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
