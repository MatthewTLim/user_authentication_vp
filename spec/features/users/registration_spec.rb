require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_username, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "test"
    fill_in :user_password_confirmation, with: "test"

    click_button 'Create New User'


    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end

  it 'does not create a user if email isnt unique' do
    user1 = User.create(
      username: 'User One',
      email: 'notunique@example.com',
      password: "fgdhjka",
      password_confirmation: "fgdhjka"
    )

    visit register_path

    fill_in :user_username, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in :user_password, with: "test"
    fill_in :user_password_confirmation, with: "test"

    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it "creates new user" do
    visit root_path

    click_on "Create New User"

    expect(current_path).to eq("/register")

    username = "funbucket13"
    email = "funbucket123@gmail.com"
    password = "test"

    fill_in :user_username, with: username
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on "Create New User"

    expect(page).to have_content("funbucket13's Dashboard")
    expect(current_path).to eq("/users/#{User.last.id}")
  end

  it "fails to create a new user when info is missing" do
    visit root_path

    click_on "Create New User"

    expect(current_path).to eq("/register")

    username = nil
    email = nil
    password = nil

    fill_in :user_username, with: username
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on "Create New User"

    expect(current_path).to eq("/register")
    expect(page).to have_content("Email can't be blank, Username can't be blank, Password confirmation doesn't match Password, Password confirmation can't be blank, and Password can't be blank")
  end


end
