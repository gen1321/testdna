# coding: utf-8

class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :middle_name, :city, :status, :actions, :email
  include Rails.application.routes.url_helpers

  def status
    handle_user_type = lambda do |user|
      case user.status
      when 'approved'
        'Зарегистрирован, подтвержден'
      when 'approved_soc'
        'Зарегистрирован, социальная сеть'
      when 'waiting_for_approve'
        'Зарегистрирован, социальная сеть'
      when 'declined'
        'Заявка на регистрацию отклонена'
      when 'banned'
        'Пользователь заблокирован'
      end
    end

    {
      type: handle_user_type.call(object),
      extra: {
        attachment: object.document.url,
        soc_url: object.soc_profile,
        banned_at: object.banned_at&.strftime('%F %H:%M')
      }
    }
  end

  def actions
    actions = {}
    actions[:approve] = approve_users_admin_path(object) if object.waiting_for_approve?
    actions[:cancel] = cancel_users_admin_path(object) if object.approved?
    actions[:ban] = ban_users_admin_path(object) unless object.banned?
    actions
  end
end
