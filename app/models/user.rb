class User < ApplicationRecord
  enum role: [:approved, :approved_soc, :waiting_for_approve, :declined, :blocked]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :waiting_for_approve
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
