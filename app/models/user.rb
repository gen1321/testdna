class User < ApplicationRecord
  enum role: %i[approved approved_soc waiting_for_approve declined blocked]
  after_initialize :set_default_role, if: :new_record?
  mount_uploader :document , DocumentUploader

  def set_default_role
    self.role ||= :waiting_for_approve
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:vkontakte]

  def self.find_for_oauth(auth)
    user_with_same_email = find_by(email: auth.info.email)
    return user_with_same_email if user_with_same_email
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name # assuming the user model has a name
      user.last_name = auth.info.last_name # assuming the user model has a name
      user.middle_name = auth.info.middle_name # assuming the user model has a name
      user.city = auth.extra.raw_info&.city&.title # i dunno for sure but i think that city can be nil
      user.approved_soc!
    end
  end
end
