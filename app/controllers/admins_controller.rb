class AdminsController < ApplicationController
  def index
    authorize :admin, :index?
    @users = ActiveModelSerializers::SerializableResource.new(User.not_admin).to_json
  end
end
