require 'stockboy/translator'

module Stockboy::Translations
  class Decimal < Stockboy::Translator

    def translate(context)
      value = context[field_key]
      return nil if value.blank?

      BigDecimal.new(value, 10)
    end

  end
end
