module UserSessions
  class CreateService
    prepend BasicService

    param :email
    param :password
    option :user, default: proc { User.find(email: @email.downcase) }, reader: false

    attr_reader :session

    def call
      validate
      create_session unless failure?
    end

    private

    def validate
      return fail_t!(:unauthorized) unless @user&.authenticate(@password)
    end

    def create_session
      @session = UserSession.new

      if @session.valid?
        @user.add_session(@session)
      else
        fail!(@session.errors)
      end
    end

    def fail_t!(key)
      fail!(I18n.t('services.user_sessions.create_service.unauthorized'))
    end
  end
end
