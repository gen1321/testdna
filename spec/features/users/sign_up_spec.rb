
feature 'Sign Up', :devise do
  scenario 'user can sign up with valid data' do
    sign_up_with(build(:user))
    expect(page).to have_content('Ваша заявка на регистрацию находится на рассмотрении у модератора')
  end

  scenario 'user cant sign up with invalid data' do
    sign_up_with(build(:user, email: 'not email'))
    expect(page).to_not have_content('Ваша заявка на регистрацию находится на рассмотрении у модератора')
  end
end
