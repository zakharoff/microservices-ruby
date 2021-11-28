class AdRoutes < Application
  helpers PaginationLinks, Auth, Geocoder

  namespace '/v1' do
    get do
      page = params[:page]&.to_i || 1
      ads = Ad.reverse_order(:updated_at)
      ads = ads.paginate(page, 20)
      serializer = AdSerializer.new(ads.all, links: pagination_links(ads))

      json serializer.serializable_hash
    end

    post do
      ad_params = validate_with!(AdParamsContract)

      result = Ads::CreateService.call(
        ad: ad_params[:ad],
        user_id: user_id
      )

      if result.success?
        serializer = AdSerializer.new(result.ad)

        status 201
        json serializer.serializable_hash
      else
        status 422
        error_response result.ad
      end
    end

    patch do
      lat, lon = params['coordinates']
      result = Ads::UpdateService.call(params['id'], lat, lon)

      result.success? ? status(200) : status(422)
    end
  end
end
