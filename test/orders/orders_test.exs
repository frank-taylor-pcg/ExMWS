defmodule ExMWS.OrdersTest do
  use ExUnit.Case, async: true
  alias ExMWS.API.Orders

  doctest Orders

  setup _context do
    go_url = Orders.get_order(["a", "b"])

    {
      :ok,
      [
        go_url: go_url,
      ]
    }
  end

  describe "get_order has the expected value in URL" do
    test "=> path", context do
      expected_value = "https://mws.amazonservices.com/Orders/2013-09-01"
      ExMWSTest.assert_contains(context[:go_url], expected_value)
    end

    test "=> order list", context do
      expected_value = "AmazonOrderId.Id.1=a&AmazonOrderId.Id.2=b"
      ExMWSTest.assert_contains(context[:go_url], expected_value)
    end

    test "=> action", context do
      expected_value = "Action=GetOrder"
      ExMWSTest.assert_contains(context[:go_url], expected_value)
    end
  end
end
