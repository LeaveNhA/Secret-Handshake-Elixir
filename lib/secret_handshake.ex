defmodule SecretHandshake do
  @codes %{1 => "wink", 2 => "double blink", 4 => "close your eyes", 8 => "jump"}
  @reverse 16

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    @codes
    |> Enum.map(fn {k, v} -> Bitwise.band(k, code) > 0 && v || "" end)
    |> Enum.filter(fn v -> v != "" end)
    # revers it if there is flip-flag! 16 decimal
    |> fn cs -> Bitwise.band(@reverse, code) > 0 && Enum.reverse(cs) || cs end.()
  end
end
