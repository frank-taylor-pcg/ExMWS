defmodule ExMWS.ProductsTest do
  use ExUnit.Case, async: true
  alias ExMWS.API.Products

  doctest Products

  setup _context do
    lmp_url   = Products.list_matching_products("test_name")
    gmp_url   = Products.get_matching_product(["test_asin"])
    gmpfi_url = Products.get_matching_product_for_id(["a", "b"], "ASIN")

    {
      :ok,
      [
        lmp_url: lmp_url,
        gmp_url: gmp_url,
        gmpfi_url: gmpfi_url
      ]
    }
  end

  #-----------------------------------------------------------------------------
  # Tests for the get_matching_product_for_id() function
  #-----------------------------------------------------------------------------
  describe "get_matching_product_for_id has the expected value in URL" do

    test "=> path", context do
      expected_value = "https://mws.amazonservices.com/Products/2011-10-01"
      ExMWSTest.assert_contains(context[:gmpfi_url], expected_value)
    end

    test "=> parameter list", context do
      expected_value = "IdList.Id.1=a&IdList.Id.2=b"
      ExMWSTest.assert_contains(context[:gmpfi_url], expected_value)
    end

    test "=> action", context do
      expected_value = "Action=GetMatchingProductForId"
      ExMWSTest.assert_contains(context[:gmpfi_url], expected_value)
    end

    test "=> id type", context do
      expected_value = "IdType=ASIN"
      ExMWSTest.assert_contains(context[:gmpfi_url], expected_value)
    end
  end

  #-----------------------------------------------------------------------------
  # Tests for the get_matching_product() function
  #-----------------------------------------------------------------------------
  describe "get_matching_product has the expected value in URL" do
    test "=> path", context do
      expected_value = "https://mws.amazonservices.com/Products/2011-10-01"
      ExMWSTest.assert_contains(context[:gmp_url], expected_value)
    end

    test "=> ASIN list", context do
      expected_value = "ASINList.ASIN.1=test_asin"
      ExMWSTest.assert_contains(context[:gmp_url], expected_value)
    end

    test "=> action", context do
      expected_value = "Action=GetMatchingProduct"
      ExMWSTest.assert_contains(context[:gmp_url], expected_value)
    end
  end

  #-----------------------------------------------------------------------------
  # Tests for the list_matching_products() function
  #-----------------------------------------------------------------------------
  describe "list_matching_product has the expected value in URL" do
    test "=> path", context do
      expected_value = "https://mws.amazonservices.com/Products/2011-10-01"
      ExMWSTest.assert_contains(context[:lmp_url], expected_value)
    end

    test "=> query", context do
      expected_value = "Query=test_name"
      ExMWSTest.assert_contains(context[:lmp_url], expected_value)
    end

    test "=> action", context do
      expected_value = "Action=ListMatchingProducts"
      ExMWSTest.assert_contains(context[:lmp_url], expected_value)
    end
  end
end
