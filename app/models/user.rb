class User < ApplicationRecord
  enum status: %i[approved approved_soc waiting_for_approve declined banned]
  after_initialize :set_default_status, if: :new_record?
  after_create :notify_admin
  mount_uploader :document , DocumentUploader

  def set_default_status
    self.status ||= :waiting_for_approve
  end

 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:vkontakte]

  def self.find_for_oauth(auth)
    user_with_same_email = find_by(email: auth.info.email)
    return user_with_same_email if user_with_same_email
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.middle_name = auth.info.middle_name
      user.city = auth.extra.raw_info&.city&.title
      user.soc_profile = auth.info.urls.Vkontakte if auth.provider == 'vkontakte'
      user.approved_soc!
    end
  end


  def banned!
    self.banned_at = Time.zone.now
    super
  end
  def admin!
    self.admin = true
    save
  end

  private

  def notify_admin
    ActionCable.server.broadcast 'admin_notifications_channel', message: ActiveModelSerializers::SerializableResource.new(self).to_json
  end
end
