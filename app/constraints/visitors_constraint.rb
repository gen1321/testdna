class VisitorsConstraint
  def initialize(&block)
    @block = block
  end

  def matches?(request)
    user = current_user(request)
    binding.pry
    @block.call(user)
  end

  def current_user(request)
    User.find_by_id(request.session[:user_id])
  end
end
