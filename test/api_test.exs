defmodule ExMWS.APITest do
  use ExUnit.Case, async: true
  alias ExMWS.API

  doctest API

  setup _context do
    generated_url = API.generate_signed_url(:get, "/Test", ["a", "b"])
    {:ok, [url: generated_url]}
  end

  test "a signed URL is contains the proper path", context do
    expected_value = "https://mws.amazonservices.com/Test"
    assert String.contains?(context[:url], expected_value)
  end

  test "a signed URL contains the expected access key", context do
    expected_value = "AWSAccessKeyId=Your+access+key+ID+here"
    assert String.contains?(context[:url], expected_value)
  end

  test "a signed URL contains the expected seller ID", context do
    expected_value = "SellerId=Your+merchant+ID+here"
    assert String.contains?(context[:url], expected_value)
  end

  test "a signed URL contains the expected signature method and version", context do
    expected_value = "SignatureMethod=HmacSHA256&SignatureVersion=2"
    assert String.contains?(context[:url], expected_value)
  end

  test "a signed URL contains the current timestamp", context do
    # I'm not actually including the time because it would always fail
    expected_value = "Timestamp="
    assert String.contains?(context[:url], expected_value)
  end

  test "a signed URL contains the expected API version", context do
    expected_value = "Version=2013-09-01"
    assert String.contains?(context[:url], expected_value)
  end

  test "a signed URL contains the given parameter list", context do
    expected_value = "a&b"
    assert String.contains?(context[:url], expected_value)
  end

  test "a signed URL contains a variable signature", context do
    expected_value = "Signature="
    assert String.contains?(context[:url], expected_value)
  end
end
