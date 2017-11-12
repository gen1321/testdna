class User < ApplicationRecord
  enum status: %i[approved approved_soc waiting_for_approve declined banned]
  after_initialize :set_default_status, if: :new_record?
  after_create :notify_admin

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  mount_uploader :document , DocumentUploader

  scope :not_admin, -> { where(admin: [ false, nil ])}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:vkontakte]

  validates :first_name, presence: true
  validates :last_name, presence: true

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

  def set_default_status
    self.status ||= :waiting_for_approve
  end

  def banned!
    self.banned_at = Time.zone.now
    super
  end

  def admin!
    self.admin = true
    save
  end

  def active_for_authentication?
    super && !self.banned?
  end


  private

  def slug_candidates
    [
      [first_name, last_name],
    ]
  end

  def notify_admin
    ActionCable.server.broadcast 'admin_notifications_channel', message: ActiveModelSerializers::SerializableResource.new(self).to_json
  end
end
