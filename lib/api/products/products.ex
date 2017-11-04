defmodule ExMWS.API.Products do
  @moduledoc """
  This is a wrapper for the Amazon MWS Products API. For further documentation
  please look here:
  http://docs.developer.amazonservices.com/en_US/products/Products_Overview.html
  """

  alias ExMWS.API

  @path "/Products/2011-10-01"

  @doc """
  Converts the list of ASINs into a list of url encoded strings

  Examples

    iex> ExMWS.API.Products.format_asins(["1", "2", "3"])
    ["ASINList.ASIN.1=1", "ASINList.ASIN.2=2", "ASINList.ASIN.3=3"]
  """
  def format_asins(asins) do
    API.format_parameters("ASINList.ASIN", asins)
  end

  @doc """
  Converts the list of IDs into a list of url encoded strings

  Examples

    iex> ExMWS.API.Products.format_idlist(["1", "2", "3"])
    ["IdList.Id.1=1", "IdList.Id.2=2", "IdList.Id.3=3"]
  """
  def format_idlist(ids) do
    API.format_parameters("IdList.Id", ids)
  end

  @doc """
  Takes a single string value and searches for matching products on Amazon.
  """
  @spec list_matching_products(String.t) :: String.t
  def list_matching_products(query) do
    query_string = "Query=" <> URI.encode_www_form(query)
    parameters = ["Action=ListMatchingProducts", query_string]
    API.generate_signed_url(:get, @path, parameters)
  end

  @doc """
  Takes a list of ASINs formatted as double-quoted strings and generates the
  signed URL for the MWS Products GetMatchingProduct operation.
  """
  @spec get_matching_product([String.t]) :: String.t
  def get_matching_product(asins)
    when is_list(asins) and length(asins) <= 20 do

    parameters = ["Action=GetMatchingProduct" | format_asins(asins)]
    API.generate_signed_url(:get, @path, parameters)
  end

  @doc """
  Takes a list of IDs formatted as double-quoted strings and generates the
  signed URL for the MWS Products GetMatchingProductForId operation.
  Valid values for `idtype` are:
    ASIN, GCID, SellerSKU, UPC, EAN, ISBN, and JAN
  """
  @spec get_matching_product_for_id([String.t], String.t) :: String.t
  def get_matching_product_for_id(ids, idtype)
    when is_list(ids) and length(ids) <= 20 do

    parameters = [
      "Action=GetMatchingProductForId",
      "IdType=#{idtype}",
      ] ++ format_idlist(ids)
    API.generate_signed_url(:get, @path, parameters)
  end

end
