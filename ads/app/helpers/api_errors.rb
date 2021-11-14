require 'sinatra/extension'

module ApiErrors
  extend Sinatra::Extension

  helpers do
    def error_response(error_messages)
      errors = case error_messages
      when Sequel::Model
        ErrorSerializer.from_model(error_messages)
      else
        ErrorSerializer.from_messages(error_messages)
      end

      json errors
    end
  end

  error Sequel::NoMatchingRow do
    status 404
    error_response I18n.t('api.errors.not_found')
  end

  error Sequel::UniqueConstraintViolation do
    status 422
    error_response I18n.t('api.errors.not_unique')
  end

  error Validations::InvalidParams, KeyError do
    status 422
    error_response I18n.t('api.errors.missing_parameters')
  end

  error Auth::Unauthorized do
    status 403
    error_response I18n.t('api.errors.unauthorized')
  end
end
