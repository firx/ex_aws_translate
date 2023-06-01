defmodule ExAws.Translate do
  @moduledoc """
  https://docs.aws.amazon.com/translate/latest/APIReference
  """

  alias ExAws.Translate.TranslationSettings
  alias ExAws.Operation.JSON

  ### AWS Translate API

  @namespace "AWSShineFrontendService_20170701"

  @spec translate_text(String.t(), String.t(), String.t()) :: JSON.t()
  def translate_text(
        source_language_code,
        target_language_code,
        text
      ) do
    settings = %TranslationSettings{
      formality: nil,
      profanity: nil
    }

    terminology_names = nil

    json_request(
      :translate_text,
      %{
        "Settings" => settings,
        "SourceLanguageCode" => source_language_code,
        "TargetLanguageCode" => target_language_code,
        "TerminologyNames" => terminology_names,
        "Text" => text
      }
    )
  end

  defp json_request(op, data, _opts \\ %{}) do
    operation =
      op
      |> Atom.to_string()
      |> Macro.camelize()

    JSON.new(
      :translate,
      %{
        data: normalise_data(data),
        # error_parser: &error_parser/1,
        headers: [
          {"x-amz-target", "#{@namespace}.#{operation}"},
          {"content-type", "application/x-amz-json-1.1"}
        ]
      }
    )
  end

  defp normalise_data(struct) when is_map(struct) do
    struct
    |> Map.drop([:__struct__])
    |> Enum.reduce(%{}, fn
      {_k, nil}, acc -> acc
      {k, v}, acc when is_atom(k) -> Map.put(acc, Macro.camelize(to_string(k)), normalise_data(v))
      {k, v}, acc -> Map.put(acc, k, normalise_data(v))
    end)
  end

  defp normalise_data(v) when is_list(v), do: Enum.map(v, &normalise_data/1)
  defp normalise_data(v) when is_binary(v), do: v
  defp normalise_data(v) when is_integer(v), do: v
  defp normalise_data(v) when is_boolean(v), do: v
end
