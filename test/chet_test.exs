defmodule ChetTest do
  use ExUnit.Case
  doctest Chet

  test "greets the world" do
    assert Chet.hello() == :world
  end
end
