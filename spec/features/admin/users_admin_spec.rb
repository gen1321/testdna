feature 'Admin Users controller' do
  context 'Non admin user' do
    scenario 'regular user cant visit any action' do
      user = create(:user)
      another_user = create(:user)
      signin(user.email, user.password)
      expect { visit approve_users_admin_path(another_user) }.to raise_error(ActionController::RoutingError)
      expect { visit ban_users_admin_path(another_user) }.to raise_error(ActionController::RoutingError)
      expect { visit cancel_users_admin_path(another_user) }.to raise_error(ActionController::RoutingError)
    end
  end

  context 'Admin' do
    before :each do
      admin = create(:user, :admin)
      @another_user = create(:user)
      signin(admin.email, admin.password)
    end

    scenario 'admin can approve user' do
      expect { visit approve_users_admin_path(@another_user) }.to_not raise_error
      expect(@another_user.reload.approved?).to eq true
    end

    scenario 'admin can ban user' do
      expect { visit ban_users_admin_path(@another_user) }.to_not raise_error
      expect(@another_user.reload.banned?).to eq true
    end

    scenario 'admin can cancel user registration' do
      expect { visit cancel_users_admin_path(@another_user) }.to_not raise_error
      expect(@another_user.reload.declined?).to eq true
    end
  end
end
