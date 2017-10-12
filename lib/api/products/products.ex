defmodule ExMWS.API.Products do
  @moduledoc """
  This is a wrapper for the Amazon MWS Products API. For further documentation
  please look here:
  http://docs.developer.amazonservices.com/en_US/products/Products_Overview.html
  """

  @path "/Products/2011-10-01"

  defp format_asins(asins) do
    ExMWS.API.format_parameters("ASINList.ASIN.", asins)
  end

  def list_matching_products(asins)
    when is_list(asins) and length(asins) <= 20 do

    parameters = ["Action=ListMatchingProducts" | format_asins(asins)]
    ExMWS.API.generate_signed_url(:get, @path, parameters)
  end
end