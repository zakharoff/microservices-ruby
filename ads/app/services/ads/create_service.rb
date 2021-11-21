module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id
    option :geocode_async, default: proc { GeocoderService::Async::Client.new }

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id

      if @ad.valid?
        @ad.save
        @geocode_async.geocode_later(@ad)
      else
        fail!(@ad.errors)
      end
    end
  end
end
