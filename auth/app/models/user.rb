class User < Sequel::Model
  plugin :association_dependencies
  plugin :secure_password, include_validations: false

  one_to_many :sessions, class: :UserSession

  add_association_dependencies sessions: :delete

  def validate
    super

    validates_presence %i[name email], message: I18n.t('validation.errors.must_be_filled')

    validates_presence :password, message: I18n.t('model.errors.user.password.must_be_filled') if new?

    validates_format(%r{\A\w+\z}, :name, message: I18n.t('validation.errors.name.format'))
  end
end
