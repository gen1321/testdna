
module Features
  module SessionHelpers
    def sign_up_with(user)
      visit new_user_registration_path
      fill_in 'Email', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
      fill_in 'user[first_name]', with: user.first_name
      fill_in 'user[last_name]', with: user.last_name
      fill_in 'user[middle_name]', with: user.middle_name
      fill_in 'user[city]', with: user.city
      attach_file('user[document]', 'spec/support/files/download.jpg')
      click_button 'Зарегестрироваться'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Пароль', with: password
      click_button 'Вход'
    end
  end
end
