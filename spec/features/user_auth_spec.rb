RSpec.feature 'User Authentication' do
  context 'Sign Up' do
    let!(:user) { User.create(email: 'dave@test.com', password: 'password123')}
    scenario 'A user can signup' do
      visit '/'
      click_on 'Sign up'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'secret123'
      click_button 'Sign up'

      expect(page).to have_content 'Welcome, test@test.com'
    end

    scenario 'A user cannot signup with same email' do
      visit '/'
      click_on 'Sign up'
      fill_in :email, with: 'dave@test.com'
      fill_in :password, with: 'password123'
      click_button 'Sign up'

      expect(page).to have_content 'Either your email has aleady been used or your password is less than 6 characters.'

    end

    scenario 'A password must be at least 6 characters' do
      visit '/'
      click_on 'Sign up'
      fill_in :email, with: 'dave@test.com'
      fill_in :password, with: 'passw'
      click_button 'Sign up'

      expect(page).to have_content 'Either your email has aleady been used or your password is less than 6 characters.'
    end
  end

  context 'Sign in/out' do
    let!(:user) { User.create(email: 'test@test.com', password: 'secret123')}

    scenario 'A user can signin' do
      visit '/'
      click_on 'Sign in'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'secret123'
      click_button 'Sign in'

      expect(page).to have_content 'Welcome, test@test.com'
    end

    scenario 'A signed in user can log out' do
      visit '/signin'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'secret123'
      click_button 'Sign in'
      click_button 'Log out'

      expect(page.current_path).to eq '/'
      expect(page).to have_content 'Sign up'
      expect(page).to have_content 'Sign in'
    end
  end
end
