defmodule ExMWSTest do
  use ExUnit.Case
  doctest ExMWS

  def assert_contains(string, substring) do
    assert String.contains?(string, substring),
      ~s(Expected:\n  #{inspect string}\nTo Contain:\n  #{inspect substring})
  end

  test "greets the world" do
    assert ExMWS.hello() == :world
  end
end
