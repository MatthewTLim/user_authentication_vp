require 'rails_helper'

RSpec.describe "User Session" do
  it "can log in and log out of a user session" do
    user = User.create(username: "funbucket13", email: "funbucket123@gmail.com", password: "test", password_confirmation: "test")
    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq('/login')

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    click_link "Home"

    expect(page).to have_link("Log Out")

    click_link "Log Out"

    expect(current_path).to eq(root_path)

    expect(page).to have_link("I already have an account")
    expect(page).to have_button("Create New User")
    expect(page).to have_content("Logged out successfully!")
  end
end