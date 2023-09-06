require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do
    @user = User.create(username: "funbucket13", email: "funbucket123@gmail.com", password: "test", password_confirmation: "test")
    @user1 = User.create(username: "User One", email: "user1@test.com", password: "adsfgfdsa", password_confirmation: "adsfgfdsa")
    @user2 = User.create(username: "User Two", email: "user2@test.com", password: "adsfgfdsa", password_confirmation: "adsfgfdsa")
    visit '/'
  end

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do
    click_button "Create New User"

    expect(current_path).to eq(register_path)

    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end

  it "does not display the list of existing users to visitors" do
    expect(page).to_not have_content("Existing Users: ")
    expect(page).to_not have_content(@user.email)
  end

  it "displays a list of existing users emails to logged in users" do

    expect(page).to_not have_content("Existing Users: ")
    expect(page).to_not have_content(@user.email)

    click_link "I already have an account"

    fill_in "Username", with: "funbucket13"
    fill_in "Password", with: "test"

    click_button "Log In"

    expect(page).to have_content(@user.email)
    expect(page).to have_content(@user1.email)
    expect(page).to have_content(@user2.email)
    expect(page).to_not have_link(@user1.email)
    expect(page).to_not have_link(@user2.email)
  end
end
