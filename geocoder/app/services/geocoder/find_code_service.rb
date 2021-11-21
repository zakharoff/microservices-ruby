module Geocoder
  class FindCodeService
    prepend BasicService

    include Dictionary

    param :city

    attr_reader :code

    def call
      @code = nil
      data = load_data!
      result = data[city]

      if result.nil?
        fail!(I18n.t('api.errors.not_found'))
      else
        @code = {lat: result[0], lon: result[1]}
      end
    end
  end
end
