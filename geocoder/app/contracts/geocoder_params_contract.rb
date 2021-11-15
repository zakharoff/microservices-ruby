class GeocoderParamsContract < Dry::Validation::Contract
  params do
    required(:geocoder).hash do
      required(:city).value(:string)
    end
  end
end
