# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Formatações de Numeros

module Currency
  BRL = {:delimiter => ".", :separator => ",", :precision => 2}
  USD = {:delimiter => ',', :separator => ".", :unit => "US$", :precision => 2, :position => "before"}
  DEFAULT = USD.merge(:unit => "")

  module String
    def to_number(options={})
      if self.numeric?
        nil
      end
      return self.gsub(/,/, '.').to_f
    end

    def numeric?
      self =~ /^(|-)?[0-9]+((\.|,)[0-9]+)?$/ ? true : false
    end
  end

  module Number
    def to_currency(options = {})
      number = self
      default   = Currency::DEFAULT.stringify_keys
      options   = default.merge(options.stringify_keys)
      precision = options["precision"] || default["precision"]
      unit      = options["unit"] || default["unit"]
      position  = options["position"] || default["position"]
      separator = precision > 0 ? options["separator"] || default["separator"] : ""
      delimiter = options["delimiter"] || default["delimiter"]

      begin
        parts = number.with_precision(precision).split('.')
        number = parts[0].to_i.with_delimiter(delimiter) + separator + parts[1].to_s
        position == "before" ? unit + number : number + unit
      rescue
        number
      end
    end

    def with_delimiter(delimiter=",", separator=".")
      number = self
      begin
        parts = number.to_s.split(separator)
        parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\1#{delimiter}")
        parts.join separator
      rescue
        self
      end
    end

    def with_precision(precision=3)
      number = self
      "%01.#{precision}f" % number
    end
  end
end
class BigDecimal; include Currency::Number; end
class Fixnum; include Currency::Number; end
class Bignum; include Currency::Number; end
class Float; include Currency::Number; end
class String; include Currency::String; end

# Formatações de Data
Date::DATE_FORMATS[:br] = "%d/%m/%Y"

