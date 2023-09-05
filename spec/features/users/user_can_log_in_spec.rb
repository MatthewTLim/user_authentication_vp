require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(username: "funbucket13", email: "funbucket123@gmail.com", password: "test", password_confirmation: "test")
    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq('/login')

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{user.username}")
  end
#   As a registered user
# When I visit the landing page `/`
# And click on the link to go to my dashboard
# And fail to fill in my correct credentials
# I'm taken back to the Log In page
# And I can see a flash message telling me that I entered incorrect credentials.

  it "can't log in with invalid credentials" do
    user = User.create(username: "funbucket13", email: "funbucket123@gmail.com", password: "test", password_confirmation: "test")
    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq('/login')

    fill_in :username, with: user.username
    fill_in :password, with: "LameAttempt"

    click_on "Log In"
   

    expect(current_path).to eq('/login')
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end