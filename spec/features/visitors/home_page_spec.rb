
feature 'Home page' do
  scenario 'unregistred user visit root page' do
    visit root_path
    expect(page).to have_content 'Вход'
  end

  scenario 'waiting_for_approve user visit root page' do
    user = create(:user, :waiting_for_approve)
    signin(user.email, user.password)
    visit root_path
    expect(page).to have_content 'Ваша заявка на регистрацию находится на рассмотрении у модератора'
  end

  scenario 'approved user visit root page' do
    user = create(:user, :approved)
    signin(user.email, user.password)
    visit root_path
    expect(page).to have_content 'Ваша заявка на регистрацию успешно подтверждена модератором, добро пожаловать!'
  end

  scenario 'approved_soc user visit root page' do
    user = create(:user, :approved_soc)
    signin(user.email, user.password)
    visit root_path
    expect(page).to have_content 'вы успешно авторизовались через соц сеть'
  end

  scenario 'declined user visit root page' do
    user = create(:user, :declined)
    signin(user.email, user.password)
    visit root_path
    expect(page).to have_content 'Ваша заявка на регистрацию отклонена из-за несоответствия переданных данных'
  end

  scenario 'banned user visit root page' do
    user = create(:user, :banned)
    signin(user.email, user.password)
    visit root_path
    expect(page).to have_content 'Вход'
  end
end
