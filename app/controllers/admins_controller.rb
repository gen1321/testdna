class AdminsController < ApplicationController
  def index
    authorize :admin, :index?
    @users = ActiveModelSerializers::SerializableResource.new(User.all).to_json
  end
end
