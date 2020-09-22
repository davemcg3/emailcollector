require 'rails_helper'

def subscribe(email)
  visit root_path
  fill_in 'email_email', with: email
  click_on 'commit'
end

def unsubscribe(email)
  visit root_path
  click_on 'Unsubscribe'
  expect(page).to have_content("We're sad to see you go")
  fill_in 'email_email', with: email
  click_on 'unsubscribe'
end

RSpec.describe 'Subscriptions', type: :feature do
  scenario 'valid email can subscribe' do
    email = 'test@test.com'
    subscribe(email)
    subscriber = Email.find_by_email(email)
    expect(subscriber.status).to be true
    expect(page).to have_current_path(emails_path)
    expect(page).to have_content('Thank you')
  end

  scenario 'No email subscribed leaves user at root path' do
    email = 'test@test.com'
    unsubscribe(email)
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('No email subscribed')
  end

  scenario 'valid subscribed email can unsubscribe' do
    email = 'test@test.com'
    subscribe(email)
    subscriber = Email.find_by_email(email)
    expect(subscriber.status).to be true
    unsubscribe(email)
    subscriber.reload
    expect(subscriber.status).to be false
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('You have been successfully unsubscribed')
  end

  scenario 'valid unsubscribed email can resubscribe' do
    email = 'test@test.com'
    subscribe(email)
    subscriber = Email.find_by_email(email)
    expect(subscriber.status).to be true
    unsubscribe(email)
    subscriber.reload
    expect(subscriber.status).to be false
    subscribe(email)
    subscriber.reload
    expect(subscriber.status).to be true
  end
end

RSpec.describe 'Rails standard methods, anon user', type: :feature do
  scenario 'cannot list all existing emails' do
    visit emails_path
    expect(page).to have_current_path(root_path)
  end

  scenario 'cannot list single existing email' do
    email = 'test@test.com'
    subscribe(email)
    visit email_path(id: Email.first.id)
    expect(page).to have_current_path(root_path)
  end

  scenario 'cannot edit' do
    email = 'test@test.com'
    subscribe(email)
    visit edit_email_path(id: Email.first.id)
    expect(page).to have_current_path(root_path)
  end

  scenario 'cannot update' do
    email = 'test@test.com'
    subscribe(email)
    subscriber = Email.find_by_email(email)
    page.driver.submit :patch, "/emails/#{Email.first.id}", {description: 'should fail to execute'}
    subscriber.reload
    expect(subscriber.description).to be nil
  end

  scenario 'cannot delete' do
    email = 'test@test.com'
    subscribe(email)
    page.driver.submit :delete, "/emails/#{Email.first.id}", {}
    expect(page).to have_current_path(root_path)
  end
end

RSpec.describe 'Rails standard methods, admin user', type: :feature do
  before(:each) do
    admin_email = 'admin@test.com'
    admin_password = '1234'
    User.create name: "Admin", email: admin_email, password: admin_password, admin: true
    visit login_path
    fill_in 'email', with: admin_email
    fill_in 'password', with: admin_password
    click_on 'Submit'
  end

  scenario 'can list all existing emails' do
    email = 'test@test.com'
    subscribe(email)
    visit emails_path
    expect(page).to have_current_path(emails_path)
    within("table") do
      expect(page).to have_text(email)
    end
  end

  scenario 'cannot list single existing email' do
    email = 'test@test.com'
    subscribe(email)
    visit email_path(id: Email.first.id)
    expect(page).to have_current_path(root_path)
  end

  scenario 'can edit' do
    email = 'test@test.com'
    subscribe(email)
    visit edit_email_path(id: Email.first.id)
    expect(page).to have_current_path(edit_email_path(Email.first.id))
  end

  scenario 'can update' do
    email = 'test@test.com'
    subscribe(email)
    subscriber = Email.find_by_email(email)
    new_description = 'should update for admin'
    page.driver.submit :patch, "/emails/#{Email.first.id}", {email: { description: new_description} }
    subscriber.reload
    expect(subscriber.description).to eq(new_description)
  end

  scenario 'can delete' do
    email = 'test@test.com'
    subscribe(email)
    expect {
      page.driver.submit :delete, "/emails/#{Email.first.id}", {}
    }.to change { Email.count }.by(-1)
    expect(page).to have_current_path(emails_path)
    within("#flash-display") do
      expect(page).to have_text("Email was successfully destroyed", minimum: 1)
    end
  end
end
