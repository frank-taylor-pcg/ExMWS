defmodule ExMWS.API do
  @moduledoc """
  Common functions that are used by multiple libraries.
  """

  defp get_common_parameters do
    [
      "AWSAccessKeyId=" <> URI.encode_www_form(Application.get_env(:exmws,
                                              :aws_access_key_id)),
      "SellerId=" <> URI.encode_www_form(Application.get_env(:exmws,
                                              :merchant_id)),
      # The docs say use version 2, but then they also say use version 4...
      "SignatureVersion=2",
      "SignatureMethod=HmacSHA256",
      "Timestamp=" <> URI.encode_www_form(Timex.format!(Timex.local,
                                              "{ISO:Extended:Z}")),
      "Version=2013-09-01"
    ]
  end

  defp calculate_signature(:get, host, path, parameter_list) do
    calculate_signature("GET", host, path, parameter_list)
  end

  defp calculate_signature(verb, host, path, parameter_list) do
    :sha256
    |> :crypto.hmac(
      Application.get_env(:exmws, :aws_secret_access_key),
      Enum.join([verb, host, path, parameter_list], "\n")
    )
    |> Base.encode64
    # This step is required because Amazon requires that all 'unsafe' characters
    # be encoded in their URL safe form (percent based encoding).
    |> URI.encode_www_form
  end

  defp build_unsigned_parameter_list(parameters) do
    (get_common_parameters() ++ parameters)
    |> Enum.sort
    |> Enum.join("&")
  end

  def generate_signed_url(:get, path, parameters) do
    host = Application.get_env(:exmws, :endpoint)
    parameter_list = build_unsigned_parameter_list(parameters)
    signature = calculate_signature(:get, host, path, parameter_list)

    query = "#{parameter_list}&Signature=#{signature}"

    uri = %URI{
      scheme: Application.get_env(:exmws, :scheme),
      host: host,
      path: path,
      query: query
    }

    IO.puts uri
    # I'm not sure how to use HTTPoison properly - this is the only part that
    # doesn't work yet. If you cut and paste the uri variable into the browser
    # you get the data, so everything up to these last two lines is working
    # correctly.
    # HTTPoison.start
    # HTTPoison.get uri
  end

  def format_parameters(identifier, parameters) do
    format_parameters(identifier, parameters, 1, [])
  end

  defp format_parameters(_, [], _, acc), do: Enum.reverse(acc)
  defp format_parameters(identifier, [h|t], index, acc) do
    current_parameter = "#{identifier}.#{index}=" <> URI.encode_www_form(h)
    format_parameters(identifier, t, index + 1, [current_parameter | acc])
  end
end
