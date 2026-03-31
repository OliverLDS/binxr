# Package index

## Configuration

- [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md)
  : Create a Binance futures configuration
- [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md)
  : Create a Binance spot configuration
- [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md)
  : Create a Binance options configuration
- [`binxr_config_futures()`](https://oliverlds.github.io/binxr/reference/binxr_config_futures.md)
  : Backward-compatible futures config constructor
- [`binxr_config_spot()`](https://oliverlds.github.io/binxr/reference/binxr_config_spot.md)
  : Backward-compatible spot config constructor
- [`binxr_config_options()`](https://oliverlds.github.io/binxr/reference/binxr_config_options.md)
  : Backward-compatible options config constructor

## Futures Market

- [`futures_get_server_time()`](https://oliverlds.github.io/binxr/reference/futures_get_server_time.md)
  [`get_fapi_system_time()`](https://oliverlds.github.io/binxr/reference/futures_get_server_time.md)
  : Get Binance Futures server time
- [`futures_ping()`](https://oliverlds.github.io/binxr/reference/futures_ping.md)
  : Test Binance Futures connectivity
- [`futures_get_exchange_info()`](https://oliverlds.github.io/binxr/reference/futures_get_exchange_info.md)
  [`get_fapi_exchange_info()`](https://oliverlds.github.io/binxr/reference/futures_get_exchange_info.md)
  : Get Binance Futures exchange info
- [`futures_get_mark_price()`](https://oliverlds.github.io/binxr/reference/futures_get_mark_price.md)
  [`get_fapi_mark_price()`](https://oliverlds.github.io/binxr/reference/futures_get_mark_price.md)
  : Get Binance Futures mark price
- [`futures_get_klines()`](https://oliverlds.github.io/binxr/reference/futures_get_klines.md)
  [`get_fapi_klines()`](https://oliverlds.github.io/binxr/reference/futures_get_klines.md)
  : Get Binance Futures klines
- [`futures_get_24hr_ticker()`](https://oliverlds.github.io/binxr/reference/futures_get_24hr_ticker.md)
  : Get Binance Futures 24hr ticker statistics
- [`futures_get_ticker_price()`](https://oliverlds.github.io/binxr/reference/futures_get_ticker_price.md)
  : Get Binance Futures ticker price
- [`futures_get_book_ticker()`](https://oliverlds.github.io/binxr/reference/futures_get_book_ticker.md)
  : Get Binance Futures order book ticker
- [`futures_get_order_book()`](https://oliverlds.github.io/binxr/reference/futures_get_order_book.md)
  : Get Binance Futures order book
- [`futures_get_recent_trades()`](https://oliverlds.github.io/binxr/reference/futures_get_recent_trades.md)
  : Get Binance Futures recent trades
- [`futures_get_aggregate_trades()`](https://oliverlds.github.io/binxr/reference/futures_get_aggregate_trades.md)
  : Get Binance Futures aggregate trades
- [`futures_get_open_interest()`](https://oliverlds.github.io/binxr/reference/futures_get_open_interest.md)
  : Get Binance Futures open interest
- [`futures_get_funding_info()`](https://oliverlds.github.io/binxr/reference/futures_get_funding_info.md)
  : Get Binance Futures funding info
- [`futures_get_funding_rate_history()`](https://oliverlds.github.io/binxr/reference/futures_get_funding_rate_history.md)
  : Get Binance Futures funding rate history
- [`futures_get_continuous_klines()`](https://oliverlds.github.io/binxr/reference/futures_get_continuous_klines.md)
  : Get Binance Futures continuous contract klines
- [`futures_get_index_price_klines()`](https://oliverlds.github.io/binxr/reference/futures_get_index_price_klines.md)
  : Get Binance Futures index price klines
- [`futures_get_mark_price_klines()`](https://oliverlds.github.io/binxr/reference/futures_get_mark_price_klines.md)
  : Get Binance Futures mark price klines
- [`futures_get_premium_index_klines()`](https://oliverlds.github.io/binxr/reference/futures_get_premium_index_klines.md)
  : Get Binance Futures premium index klines

## Futures Account

- [`futures_get_account()`](https://oliverlds.github.io/binxr/reference/futures_get_account.md)
  [`get_fapi_account()`](https://oliverlds.github.io/binxr/reference/futures_get_account.md)
  : Get Binance Futures account info
- [`futures_get_position_risk()`](https://oliverlds.github.io/binxr/reference/futures_get_position_risk.md)
  [`get_fapi_account_position_risk()`](https://oliverlds.github.io/binxr/reference/futures_get_position_risk.md)
  : Get Binance Futures position risk
- [`futures_get_positions()`](https://oliverlds.github.io/binxr/reference/futures_get_positions.md)
  [`get_fapi_account_positions()`](https://oliverlds.github.io/binxr/reference/futures_get_positions.md)
  : Get standardized Binance Futures positions
- [`futures_get_account_summary()`](https://oliverlds.github.io/binxr/reference/futures_get_account_summary.md)
  [`get_fapi_account_summary()`](https://oliverlds.github.io/binxr/reference/futures_get_account_summary.md)
  : Get Binance Futures account summary
- [`futures_get_balance()`](https://oliverlds.github.io/binxr/reference/futures_get_balance.md)
  : Get Binance Futures balances
- [`futures_get_position_mode()`](https://oliverlds.github.io/binxr/reference/futures_get_position_mode.md)
  : Get Binance Futures position mode
- [`futures_get_multi_assets_mode()`](https://oliverlds.github.io/binxr/reference/futures_get_multi_assets_mode.md)
  : Get Binance Futures multi-assets mode
- [`futures_get_commission_rate()`](https://oliverlds.github.io/binxr/reference/futures_get_commission_rate.md)
  : Get Binance Futures commission rate
- [`futures_get_order_rate_limit()`](https://oliverlds.github.io/binxr/reference/futures_get_order_rate_limit.md)
  : Get Binance Futures order rate limits

## Futures Trading

- [`futures_set_margin_type()`](https://oliverlds.github.io/binxr/reference/futures_set_margin_type.md)
  [`set_fapi_account_margin_type()`](https://oliverlds.github.io/binxr/reference/futures_set_margin_type.md)
  : Set Binance Futures margin type
- [`futures_set_leverage()`](https://oliverlds.github.io/binxr/reference/futures_set_leverage.md)
  [`set_fapi_account_leverage()`](https://oliverlds.github.io/binxr/reference/futures_set_leverage.md)
  : Set Binance Futures leverage
- [`futures_set_position_mode()`](https://oliverlds.github.io/binxr/reference/futures_set_position_mode.md)
  [`set_fapi_account_position_side()`](https://oliverlds.github.io/binxr/reference/futures_set_position_mode.md)
  : Set Binance Futures position mode
- [`futures_place_order()`](https://oliverlds.github.io/binxr/reference/futures_place_order.md)
  [`place_fapi_trade_order()`](https://oliverlds.github.io/binxr/reference/futures_place_order.md)
  : Place a Binance Futures order
- [`futures_test_order()`](https://oliverlds.github.io/binxr/reference/futures_test_order.md)
  : Test a Binance Futures order
- [`futures_cancel_order()`](https://oliverlds.github.io/binxr/reference/futures_cancel_order.md)
  [`cancel_fapi_trade_order()`](https://oliverlds.github.io/binxr/reference/futures_cancel_order.md)
  : Cancel a Binance Futures order
- [`futures_cancel_all_orders()`](https://oliverlds.github.io/binxr/reference/futures_cancel_all_orders.md)
  [`cancel_fapi_trade_orders_all()`](https://oliverlds.github.io/binxr/reference/futures_cancel_all_orders.md)
  : Cancel all open Binance Futures orders for a symbol
- [`futures_get_open_orders()`](https://oliverlds.github.io/binxr/reference/futures_get_open_orders.md)
  [`get_fapi_trade_open_orders()`](https://oliverlds.github.io/binxr/reference/futures_get_open_orders.md)
  : Get Binance Futures open orders
- [`futures_get_orders()`](https://oliverlds.github.io/binxr/reference/futures_get_orders.md)
  [`get_fapi_trade_orders()`](https://oliverlds.github.io/binxr/reference/futures_get_orders.md)
  : Get Binance Futures order history
- [`futures_get_order()`](https://oliverlds.github.io/binxr/reference/futures_get_order.md)
  [`get_fapi_trade_order()`](https://oliverlds.github.io/binxr/reference/futures_get_order.md)
  : Get a Binance Futures order
- [`futures_get_account_trades()`](https://oliverlds.github.io/binxr/reference/futures_get_account_trades.md)
  : Get Binance Futures account trades
- [`futures_get_force_orders()`](https://oliverlds.github.io/binxr/reference/futures_get_force_orders.md)
  : Get Binance Futures force orders
- [`futures_set_multi_assets_mode()`](https://oliverlds.github.io/binxr/reference/futures_set_multi_assets_mode.md)
  : Set Binance Futures multi-assets mode
- [`futures_countdown_cancel_all()`](https://oliverlds.github.io/binxr/reference/futures_countdown_cancel_all.md)
  : Set Binance Futures countdown cancel-all

## Spot Market

- [`spot_ping()`](https://oliverlds.github.io/binxr/reference/spot_ping.md)
  : Test Binance Spot API connectivity
- [`spot_get_server_time()`](https://oliverlds.github.io/binxr/reference/spot_get_server_time.md)
  : Get Binance Spot server time
- [`spot_get_exchange_info()`](https://oliverlds.github.io/binxr/reference/spot_get_exchange_info.md)
  : Get Binance Spot exchange information
- [`spot_get_ticker_price()`](https://oliverlds.github.io/binxr/reference/spot_get_ticker_price.md)
  [`get_spot_mark_price()`](https://oliverlds.github.io/binxr/reference/spot_get_ticker_price.md)
  : Get Binance Spot ticker price
- [`spot_get_book_ticker()`](https://oliverlds.github.io/binxr/reference/spot_get_book_ticker.md)
  : Get Binance Spot book ticker
- [`spot_get_24hr_ticker()`](https://oliverlds.github.io/binxr/reference/spot_get_24hr_ticker.md)
  : Get Binance Spot 24-hour ticker statistics
- [`spot_get_trading_day_ticker()`](https://oliverlds.github.io/binxr/reference/spot_get_trading_day_ticker.md)
  : Get Binance Spot trading day ticker statistics
- [`spot_get_rolling_window_ticker()`](https://oliverlds.github.io/binxr/reference/spot_get_rolling_window_ticker.md)
  : Get Binance Spot rolling window ticker statistics
- [`spot_get_order_book()`](https://oliverlds.github.io/binxr/reference/spot_get_order_book.md)
  : Get Binance Spot order book
- [`spot_get_recent_trades()`](https://oliverlds.github.io/binxr/reference/spot_get_recent_trades.md)
  : Get Binance Spot recent trades
- [`spot_get_historical_trades()`](https://oliverlds.github.io/binxr/reference/spot_get_historical_trades.md)
  : Get Binance Spot historical trades
- [`spot_get_aggregate_trades()`](https://oliverlds.github.io/binxr/reference/spot_get_aggregate_trades.md)
  : Get Binance Spot aggregate trades
- [`spot_get_klines()`](https://oliverlds.github.io/binxr/reference/spot_get_klines.md)
  : Get Binance Spot klines
- [`spot_get_ui_klines()`](https://oliverlds.github.io/binxr/reference/spot_get_ui_klines.md)
  : Get Binance Spot UI klines
- [`spot_get_average_price()`](https://oliverlds.github.io/binxr/reference/spot_get_average_price.md)
  : Get Binance Spot average price
- [`spot_get_reference_price()`](https://oliverlds.github.io/binxr/reference/spot_get_reference_price.md)
  : Get Binance Spot reference price
- [`spot_get_reference_price_calculation()`](https://oliverlds.github.io/binxr/reference/spot_get_reference_price_calculation.md)
  : Get Binance Spot reference price calculation metadata
- [`spot_get_execution_rules()`](https://oliverlds.github.io/binxr/reference/spot_get_execution_rules.md)
  : Get Binance Spot execution rules
- [`spot_get_relevant_filters()`](https://oliverlds.github.io/binxr/reference/spot_get_relevant_filters.md)
  : Get Binance Spot relevant account filters

## Spot Account

- [`spot_get_account()`](https://oliverlds.github.io/binxr/reference/spot_get_account.md)
  : Get Binance Spot account information
- [`spot_get_order()`](https://oliverlds.github.io/binxr/reference/spot_get_order.md)
  : Get a Binance Spot order
- [`spot_get_open_orders()`](https://oliverlds.github.io/binxr/reference/spot_get_open_orders.md)
  : Get Binance Spot open orders
- [`spot_get_orders()`](https://oliverlds.github.io/binxr/reference/spot_get_orders.md)
  : Get Binance Spot order history
- [`spot_get_order_list()`](https://oliverlds.github.io/binxr/reference/spot_get_order_list.md)
  : Get a Binance Spot order list
- [`spot_get_all_order_lists()`](https://oliverlds.github.io/binxr/reference/spot_get_all_order_lists.md)
  : Get all Binance Spot order lists
- [`spot_get_open_order_lists()`](https://oliverlds.github.io/binxr/reference/spot_get_open_order_lists.md)
  : Get Binance Spot open order lists
- [`spot_get_account_trades()`](https://oliverlds.github.io/binxr/reference/spot_get_account_trades.md)
  : Get Binance Spot account trades
- [`spot_get_unfilled_order_count()`](https://oliverlds.github.io/binxr/reference/spot_get_unfilled_order_count.md)
  : Get Binance Spot unfilled order counts
- [`spot_get_prevented_matches()`](https://oliverlds.github.io/binxr/reference/spot_get_prevented_matches.md)
  : Get Binance Spot prevented matches
- [`spot_get_allocations()`](https://oliverlds.github.io/binxr/reference/spot_get_allocations.md)
  : Get Binance Spot allocations
- [`spot_get_commission_rates()`](https://oliverlds.github.io/binxr/reference/spot_get_commission_rates.md)
  : Get Binance Spot commission rates
- [`spot_get_order_amendments()`](https://oliverlds.github.io/binxr/reference/spot_get_order_amendments.md)
  : Get Binance Spot order amendments

## Spot Trading

- [`spot_place_order()`](https://oliverlds.github.io/binxr/reference/spot_place_order.md)
  : Place a Binance Spot order
- [`spot_test_order()`](https://oliverlds.github.io/binxr/reference/spot_test_order.md)
  : Test a Binance Spot order
- [`spot_cancel_order()`](https://oliverlds.github.io/binxr/reference/spot_cancel_order.md)
  : Cancel a Binance Spot order
- [`spot_cancel_all_orders()`](https://oliverlds.github.io/binxr/reference/spot_cancel_all_orders.md)
  : Cancel all open Binance Spot orders for a symbol
- [`spot_cancel_replace_order()`](https://oliverlds.github.io/binxr/reference/spot_cancel_replace_order.md)
  : Cancel and replace a Binance Spot order
- [`spot_amend_order_keep_priority()`](https://oliverlds.github.io/binxr/reference/spot_amend_order_keep_priority.md)
  : Amend a Binance Spot order while keeping priority
- [`spot_place_oco_order()`](https://oliverlds.github.io/binxr/reference/spot_place_oco_order.md)
  : Place a deprecated Binance Spot OCO order
- [`spot_cancel_order_list()`](https://oliverlds.github.io/binxr/reference/spot_cancel_order_list.md)
  : Cancel a Binance Spot order list
- [`spot_place_order_list_oco()`](https://oliverlds.github.io/binxr/reference/spot_place_order_list_oco.md)
  : Place a Binance Spot OCO order list
- [`spot_place_order_list_oto()`](https://oliverlds.github.io/binxr/reference/spot_place_order_list_oto.md)
  : Place a Binance Spot OTO order list
- [`spot_place_order_list_otoco()`](https://oliverlds.github.io/binxr/reference/spot_place_order_list_otoco.md)
  : Place a Binance Spot OTOCO order list
- [`spot_place_order_list_opo()`](https://oliverlds.github.io/binxr/reference/spot_place_order_list_opo.md)
  : Place a Binance Spot OPO order list
- [`spot_place_order_list_opoco()`](https://oliverlds.github.io/binxr/reference/spot_place_order_list_opoco.md)
  : Place a Binance Spot OPOCO order list
- [`spot_place_sor_order()`](https://oliverlds.github.io/binxr/reference/spot_place_sor_order.md)
  : Place a Binance Spot SOR order
- [`spot_test_sor_order()`](https://oliverlds.github.io/binxr/reference/spot_test_sor_order.md)
  : Test a Binance Spot SOR order

## Options Market

- [`options_ping()`](https://oliverlds.github.io/binxr/reference/options_ping.md)
  : Test Binance Options connectivity
- [`options_get_server_time()`](https://oliverlds.github.io/binxr/reference/options_get_server_time.md)
  : Get Binance Options server time
- [`options_get_exchange_info()`](https://oliverlds.github.io/binxr/reference/options_get_exchange_info.md)
  : Get Binance Options exchange info
- [`options_get_index_price()`](https://oliverlds.github.io/binxr/reference/options_get_index_price.md)
  : Get Binance Options underlying index price
- [`options_get_order_book()`](https://oliverlds.github.io/binxr/reference/options_get_order_book.md)
  : Get Binance Options order book
- [`options_get_recent_trades()`](https://oliverlds.github.io/binxr/reference/options_get_recent_trades.md)
  : Get Binance Options recent trades
- [`options_get_recent_block_trades()`](https://oliverlds.github.io/binxr/reference/options_get_recent_block_trades.md)
  : Get Binance Options recent block trades
- [`options_get_klines()`](https://oliverlds.github.io/binxr/reference/options_get_klines.md)
  : Get Binance Options klines
- [`options_get_mark_price()`](https://oliverlds.github.io/binxr/reference/options_get_mark_price.md)
  : Get Binance Options mark prices
- [`options_get_24hr_ticker()`](https://oliverlds.github.io/binxr/reference/options_get_24hr_ticker.md)
  : Get Binance Options 24hr ticker statistics
- [`options_get_open_interest()`](https://oliverlds.github.io/binxr/reference/options_get_open_interest.md)
  : Get Binance Options open interest
- [`options_get_exercise_history()`](https://oliverlds.github.io/binxr/reference/options_get_exercise_history.md)
  : Get Binance Options historical exercise records

## Options Account and Trading

- [`options_get_margin_account()`](https://oliverlds.github.io/binxr/reference/options_get_margin_account.md)
  : Get Binance Options margin account information
- [`options_place_order()`](https://oliverlds.github.io/binxr/reference/options_place_order.md)
  : Place a Binance Options order
- [`options_get_order()`](https://oliverlds.github.io/binxr/reference/options_get_order.md)
  : Get a Binance Options order
- [`options_cancel_order()`](https://oliverlds.github.io/binxr/reference/options_cancel_order.md)
  : Cancel a Binance Options order
- [`options_cancel_all_orders()`](https://oliverlds.github.io/binxr/reference/options_cancel_all_orders.md)
  : Cancel all Binance Options orders for a symbol
- [`options_cancel_all_orders_by_underlying()`](https://oliverlds.github.io/binxr/reference/options_cancel_all_orders_by_underlying.md)
  : Cancel all Binance Options orders by underlying
- [`options_get_open_orders()`](https://oliverlds.github.io/binxr/reference/options_get_open_orders.md)
  : Get Binance Options open orders
- [`options_get_order_history()`](https://oliverlds.github.io/binxr/reference/options_get_order_history.md)
  : Get Binance Options order history
- [`options_get_account_trades()`](https://oliverlds.github.io/binxr/reference/options_get_account_trades.md)
  : Get Binance Options account trades
- [`options_get_positions()`](https://oliverlds.github.io/binxr/reference/options_get_positions.md)
  : Get Binance Options positions
- [`options_get_commission()`](https://oliverlds.github.io/binxr/reference/options_get_commission.md)
  : Get Binance Options user commission
- [`options_get_funding_flow()`](https://oliverlds.github.io/binxr/reference/options_get_funding_flow.md)
  : Get Binance Options funding flow
- [`options_get_exercise_records()`](https://oliverlds.github.io/binxr/reference/options_get_exercise_records.md)
  : Get Binance Options exercise records

## Helpers

- [`round_price_qty()`](https://oliverlds.github.io/binxr/reference/round_price_qty.md)
  [`util_round_price_qty()`](https://oliverlds.github.io/binxr/reference/round_price_qty.md)
  : Round price and quantity to exchange increments
- [`coerce_account_frames()`](https://oliverlds.github.io/binxr/reference/coerce_account_frames.md)
  : (Optional) Coerce account to data.frames
