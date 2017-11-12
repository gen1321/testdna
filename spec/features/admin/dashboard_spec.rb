# coding: utf-8

feature 'Admin Dashboard' do
  scenario 'not user cant visit dashboard' do
    user = create(:user)
    signin(user.email, user.password)
    expect { visit admin_path }.to raise_error(ActionController::RoutingError)
  end

  context 'Admin' do
    before :each do
      @user = create(:user, :admin)
    end

    scenario 'admin user can visit dashboard' do
      signin(@user.email, @user.password)
      expect { visit admin_path }.to_not raise_error
      expect(page).to have_content 'Действия'
    end
  end
end
