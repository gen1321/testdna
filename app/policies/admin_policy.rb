# rubocop:disable Style/StructInheritance
class AdminPolicy < Struct.new(:user, :admin)
  attr_reader :current_user

  def initialize(current_user, _)
    @current_user = current_user
  end

  def index?
    @current_user.admin
  end
end
# rubocop:enable Style/StructInheritance
