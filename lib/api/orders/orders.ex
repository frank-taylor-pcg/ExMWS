defmodule ExMWS.API.Orders do
  @moduledoc """
  This is a wrapper for the Amazon MWS Orders API. For further documentation
  please look here:
  http://docs.developer.amazonservices.com/en_US/orders-2013-09-01/Orders_Overview.html
  """

  @path "/Orders/2013-09-01"

  # Converts the list of orders into a list of url encoded strings
  defp format_orders(orders) do
    ExMWS.API.format_parameters("AmazonOrderId.Id.", orders)
  end

  @doc """
  Takes a list of orders formatted as double-quoted strings and generates the
  signed URL for the MWS Orders GetOrder operation.
  """
  @spec get_order([String.t]) :: String.t
  def get_order(orders)
    when is_list(orders) and length(orders) <= 50 do

    parameters = ["Action=GetOrder" | format_orders(orders)]
    ExMWS.API.generate_signed_url(:get, @path, parameters)
  end

  # defp list_orders, do: IO.puts "Not yet implemented"
  #
  # @spec list_orders_created_after(date) :: String.t
  # def list_orders_created_after(date) do
  #   list_orders(:created_after, date)
  # end
  #
  # @spec list_orders_last_updated_after(date) :: String.t
  # def list_orders_last_updated_after(date) do
  #   list_orders(:last_updated_after, date)
  # end

  # The remaining portions of the Order API that I haven't started working on.
  def list_orders_by_next_token, do: IO.puts "Not yet implemented"
  def list_order_items, do: IO.puts "Not yet implemented"
  def list_order_items_by_next_token, do: IO.puts "Not yet implemented"
  def get_service_status, do: IO.puts "Not yet implemented"
end
