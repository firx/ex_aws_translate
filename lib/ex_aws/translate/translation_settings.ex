defmodule ExAws.Translate.TranslationSettings do
  @moduledoc """
  Module representing the Chime TranslationSettings data type

  See https://docs.aws.amazon.com/translate/latest/APIReference/API_TranslationSettings.html
  """

  defstruct [
    :formality,
    :profanity
  ]

  @type t :: %__MODULE__{
          # "FORMAL" | "INFORMAL"
          formality: String.t() | nil,
          # "MASK"
          profanity: String.t() | nil
        }
end
