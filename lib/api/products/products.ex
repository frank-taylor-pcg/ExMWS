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

  @doc """
  Takes a single string value and searches for matching products on Amazon.
  """
  @spec list_matching_products(String.t) :: String.t
  def list_matching_products(query) do
    query_string = "Query=" <> URI.encode_www_form("query")
    parameters = ["Action=ListMatchingProducts" | query_string]
    ExMWS.API.generate_signed_url(:get, @path, parameters)
  end

  @doc """
  Takes a list of ASINs formatted as double-quoted strings and generates the
  signed URL for the MWS Products GetMatchingProduct operation.
  """
  @spec get_matching_product([String.t]) :: String.t
  def get_matching_product(asins)
    when is_list(asins) and length(asins) <= 50 do

    parameters = ["Action=GetMatchingProduct" | format_asins(asins)]
    ExMWS.API.generate_signed_url(:get, @path, parameters)
  end

end