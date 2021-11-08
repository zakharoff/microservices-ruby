class Ad < Sequel::Model
  def validate
    super
    validates_presence %i[title description city], message: I18n.t('validation.errors.must_be_filled')
  end
end
