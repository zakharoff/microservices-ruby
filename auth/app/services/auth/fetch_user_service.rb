module Auth
  class FetchUserService
    prepend BasicService

    param :uuid

    attr_reader :user

    def call
      return fail!(I18n.t('services.auth.fetch_user_service.forbidden')) if @uuid.blank? || session.blank?
      @user = session.user
    end

    private

    def session
      @session ||= UserSession.find(uuid: @uuid)
    rescue => e
      raise unless e.cause.kind_of?(PG::InvalidTextRepresentation)
    end
  end
end
