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

      result =

      if result.success?
        serializer = AdSerializer.new(result.ad)

        status 201
        json serializer.serializable_hash
      else
        status 422
        error_response result.ad
      end
    end
  end
end
