class UserSession < Sequel::Model
  plugin :uuid

  many_to_one :user

  def validate
    super
    validates_presence :uuid, message: I18n.t('validation.errors.must_be_filled')
  end
end
