class User < Sequel::Model
  plugin :association_dependencies
  plugin :secure_password, include_validations: false

  NAME_FORMAT = %r{\A\w+\z}

  one_to_many :sessions, class: :UserSession

  add_association_dependencies sessions: :delete

  def validate
    super

    validates_presence %i[name email], message: I18n.t('validation.errors.must_be_filled')

    validates_presence :password, message: I18n.t('model.errors.user.password.must_be_filled') if new?

    validates_format(NAME_FORMAT, :name, message: I18n.t('validation.errors.name.format'))
  end
end
