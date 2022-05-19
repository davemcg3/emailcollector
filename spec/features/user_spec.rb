require 'rails_helper'

RSpec.describe 'Anon user actions', type: :feature do
  scenario 'can register user' do
    visit new_user_path
    name = 'Anon-created'
    fill_in 'user_name', with: name
    fill_in 'user_email', with: 'admin-created@test.com'
    fill_in 'user_password', with: '1234'
    fill_in 'user_password_confirmation', with: '1234'
    click_on 'Save'
    within('body') do
      expect(page).to have_text(name)
    end
    expect(User.last.admin).to be false
  end

  scenario 'cannot visit the page to update user' do
    anon_email = 'anon-created@test.com'
    anon_password = '1234'
    anon_user = User.create name: "Anon", email: anon_email, password: anon_password
    visit edit_user_path(id: anon_user.id)
    expect(page).to have_current_path(root_path)
  end

  scenario 'cannot update self or grant admin to self' do
    anon_email = 'anon-created@test.com'
    anon_password = '1234'
    anon_user = User.create name: "Anon", email: anon_email, password: anon_password
    page.driver.submit :patch, "/users/#{anon_user.id}", {name: 'should fail to execute', admin: true}
    anon_user.reload
    expect(anon_user.name).to eq(anon_user.name)
    expect(anon_user.admin).to be false
  end

  scenario 'cannot update other user or grant admin' do
    anon_email = 'anon-created@test.com'
    anon_password = '1234'
    anon_name = "Anon"
    anon_user = User.create name: anon_name, email: anon_email, password: anon_password
    page.driver.submit :patch, "/users/#{anon_user.id}", {name: 'should fail to execute'}
    anon_user.reload
    expect(anon_user.name).to eq(anon_name)
  end

  scenario 'cannot delete user' do
    standard_email = 'standard-created@test.com'
    standard_name = 'Standard'
    standard_password = '1234'
    standard_user = User.create name: standard_name, email: standard_email, password: standard_password
    expect {
      page.driver.submit :delete, "/users/#{standard_user.id}", {}
    }.not_to change { User.count }
    expect( User.find(standard_user.id).name ).to eq(standard_name)
  end

  scenario 'cannot view all users' do
    visit users_path
    within('body') do
      expect(page).to have_current_path(root_path)
    end
  end

  scenario 'cannot view single user' do
    standard_email = 'standard-created@test.com'
    standard_name = 'Standard'
    standard_password = '1234'
    standard_user = User.create name: standard_name, email: standard_email, password: standard_password
    visit user_path(id: standard_user.id)
    within('body') do
      expect(page).to have_current_path(root_path)
    end
  end
end

RSpec.describe 'Standard user actions', type: :feature do
  before(:each) do
    standard_email = 'standard@test.com'
    standard_password = '1234'
    @standard = User.create name: "Standard", email: standard_email, password: standard_password, admin: false
    visit login_path
    fill_in 'email', with: standard_email
    fill_in 'password', with: standard_password
    click_on 'Submit'
  end

  scenario 'can register user' do
    visit new_user_path
    name = 'Standard-created'
    fill_in 'user_name', with: name
    fill_in 'user_email', with: 'admin-created@test.com'
    fill_in 'user_password', with: '1234'
    fill_in 'user_password_confirmation', with: '1234'
    click_on 'Save'
    within('body') do
      expect(page).to have_text(name)
    end
    expect(User.last.admin).to be false
  end

  scenario 'cannot visit the page to update self' do
    visit edit_user_path(id: @standard.id)
    expect(page).to have_current_path(root_path)
  end

  scenario 'cannot visit the page to update user' do
    standard_email = 'standard-created@test.com'
    standard_password = '1234'
    standard_user = User.create name: "Standard", email: standard_email, password: standard_password
    visit edit_user_path(id: standard_user.id)
    expect(page).to have_current_path(root_path)
  end

  scenario 'cannot update self or grant admin' do
    page.driver.submit :patch, "/users/#{@standard.id}", {name: 'should fail to execute', admin: true}
    @standard.reload
    expect(@standard.name).to eq(@standard.name)
    expect(@standard.admin).to be false
  end

  scenario 'cannot update other user or grant admin' do
    standard_email = 'standard-created@test.com'
    standard_name = 'Standard'
    standard_password = '1234'
    standard_user = User.create name: standard_name, email: standard_email, password: standard_password
    page.driver.submit :patch, "/users/#{standard_user.id}", {name: 'should fail to execute'}
    standard_user.reload
    expect(standard_user.name).to eq(standard_name)
  end

  scenario 'cannot delete user' do
    standard_email = 'standard-created@test.com'
    standard_name = 'Standard'
    standard_password = '1234'
    standard_user = User.create name: standard_name, email: standard_email, password: standard_password
    expect {
      page.driver.submit :delete, "/users/#{standard_user.id}", {}
    }.not_to change { User.count }
    expect( User.find(standard_user.id).name ).to eq(standard_name)
  end

  scenario 'cannot view all users' do
    visit users_path
    within('body') do
      expect(page).to have_current_path(root_path)
    end
  end

  scenario 'cannot view single user' do
    visit user_path(id: @standard.id)
    within('body') do
      expect(page).to have_current_path(root_path)
    end
  end
end

RSpec.describe 'Admin user actions', type: :feature do
  before(:each) do
    admin_email = 'admin@test.com'
    admin_password = '1234'
    @admin = User.create name: "Admin", email: admin_email, password: admin_password, admin: true
    visit login_path
    fill_in 'email', with: admin_email
    fill_in 'password', with: admin_password
    click_on 'Submit'
  end

  scenario 'can register user' do
    visit new_user_path
    name = 'Admin-created'
    fill_in 'user_name', with: name
    fill_in 'user_email', with: 'admin-created@test.com'
    fill_in 'user_password', with: '1234'
    fill_in 'user_password_confirmation', with: '1234'
    click_on 'Save'
    within('body') do
      expect(page).to have_text(name)
    end
    expect(User.last.admin).to be false
  end

  scenario 'can update self' do
    visit edit_user_path(id: @admin.id)
    edited_name = 'admin-edited'
    fill_in 'user_name', with: edited_name
    click_on 'Save'
    within('body') do
      expect(page).to have_text(edited_name)
    end
    @admin.reload
    expect(@admin.name).to eq(edited_name)
    expect(@admin.admin).to be true
  end

  scenario 'can update user' do
    standard_email = 'standard@test.com'
    standard_password = '1234'
    standard_user = User.create name: "Standard", email: standard_email, password: standard_password
    visit edit_user_path(id: standard_user.id)
    edited_name = 'admin-edited'
    fill_in 'user_name', with: edited_name
    click_on 'Save'
    within('body') do
      expect(page).to have_text(edited_name)
    end
    standard_user.reload
    expect(standard_user.name).to eq(edited_name)
    expect(standard_user.admin).to be false
  end

  scenario 'can promote user to admin' do
    standard_email = 'standard@test.com'
    standard_password = '1234'
    standard_user = User.create name: "Standard", email: standard_email, password: standard_password
    visit edit_user_path(id: standard_user.id)
    check 'user_admin'
    click_on 'Save'
    standard_user.reload
    expect(standard_user.admin).to be true
  end

  scenario 'can delete user' do
    standard_email = 'standard-created@test.com'
    standard_name = 'Standard'
    standard_password = '1234'
    standard_user = User.create name: standard_name, email: standard_email, password: standard_password
    visit users_path
    within('table') do
      expect(page).to have_text(standard_user.name)
    end
    expect {
      within('body') do
        click_link('Destroy', href: "/users/#{standard_user.id}") # wrong number of arguments given, expected 0..1
      end
    }.to change { User.count }.by(-1)
    expect { User.find(standard_user.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end

  scenario 'can view all users' do
    visit users_path
    within('body') do
      expect(page).to have_content(@admin.email)
    end
  end

  scenario 'can view single user' do
    visit user_path(id: @admin.id)
    within('body') do
      expect(page).to have_content(@admin.email)
    end
  end
end

