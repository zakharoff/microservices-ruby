require 'sinatra/extension'

module ApiErrors
  extend Sinatra::Extension

  helpers do
    def error_response(error_message)
      json ErrorSerializer.from_messages(error_message)
    end
  end

  error Validations::InvalidParams, KeyError do
    status 422
    error_response I18n.t('api.errors.missing_parameters')
  end
end
