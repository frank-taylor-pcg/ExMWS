defmodule ExMWS do
  @moduledoc """
  A quick prototype to see how easily I can connect to the Amazon MWS Order API
  and pull an order.
  """

  alias ExMWS.API.Orders

  def get_orders() do
    # Replace this with actual order numbers
    order_list = [
      # Place orders here (make sure to use double-quotes)
    ]

    # Request the list of orders from Amazon and dump the raw results
    order_list
    |> Orders.get_order
    |> IO.inspect
  end
end
