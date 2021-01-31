require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do

  def user_login
    visit new_session_path
    fill_in 'session[email]', with: 'test@test.com'
    fill_in 'session[password]', with: '11111111'
    click_button 'ログイン'
  end

  def admin_user_login
    visit new_session_path
    fill_in 'session[email]', with: 'admin@admin.com'
    fill_in 'session[password]', with: '00000000'
    click_button 'ログイン'
  end

  describe 'ユーザー登録機能' do
    context 'ユーザーのデータがなくログインしていない状態' do
      it 'ユーザー新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'テスト'
        fill_in 'user[email]', with: 'test@test.com'
        fill_in 'user[password]', with: '11111111'
        fill_in 'user[password_confirmation]', with: '11111111'
        click_on 'アカウント作成'

        click_link 'マイページ'

        expect(page).to have_content 'テストのページ'
        expect(page).to have_content 'test@test.com'
      end
      it 'ログインしていない時はログイン画面に飛ぶ' do
        visit root_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
      user_login
    end

    context 'ログインしていない状態でユーザーのデータが登録されている場合' do
      it 'ログインができること' do
        # sleep 1
        # visit new_session_path
        # fill_in 'user[email]',with: 'test@test.com'
        # fill_in 'user[password]',with: '11111111'
        # click_button 'ログイン'

        expect(current_path).to eq root_path
      end
    end

    context '一般ユーザーでログインしている状態' do
      it '自分の詳細画面に飛べること' do
        click_link 'マイページ'
        sleep 1
        expect(page).to have_content 'テストのページ'
      end

      it '一般ユーザーが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        sleep 1
        visit user_path(@admin_user.id)
        expect(current_path).to eq root_path
      end

      it 'ログアウトできること' do
        click_link 'Logout'

        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '管理画面機能' do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
    end

    context '一般ユーザーでログインしている時' do
      it '一般ユーザーは管理画面にアクセスできない' do
        user_login

        visit admin_users_path
        expect(current_path).to eq root_path
      end
    end

    context '管理者でログインしている時' do
      before do
        admin_user_login
        sleep 1
        click_link '管理者画面/ユーザー一覧へ'
      end

      it '管理者は管理画面にアクセスできる' do
        expect(current_path).to eq admin_users_path
      end

      it '管理者はユーザーを新規登録できる' do
        sleep 1
        click_link '新規ユーザー登録'

        fill_in 'user[name]', with: 'test2'
        fill_in 'user[email]', with: 'test2@test2.com'
        fill_in 'user[password]', with: '22222222'
        fill_in 'user[password_confirmation]', with: '22222222'
        click_on 'アカウント作成'

        visit admin_users_path
        expect(page).to have_content 'test2'
      end

      it '管理者はユーザー詳細画面にアクセスできる' do
        sleep 1
        click_link 'ユーザー情報詳細', href: admin_user_path(@user.id)
        expect(current_path).to eq admin_user_path(@user.id)
        expect(page).to have_content 'test@test.com'
      end

      it '管理者はユーザーの編集画面からユーザー情報を編集できる' do
        sleep 1
        visit admin_users_path
        click_link 'ユーザー情報編集', href: edit_admin_user_path(@user.id)

        fill_in 'user[name]', with: 'test3'
        fill_in 'user[email]', with: 'test3@test3.com'
        fill_in 'user[password]', with: '33333333'
        fill_in 'user[password_confirmation]', with: '33333333'
        click_button '実行'

        expect(page).to have_content 'test3'
      end

      it '管理者はユーザの削除をできること' do
        sleep 1
        click_link 'ユーザー情報削除', href: admin_user_path(@user.id)
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content 'ユーザー「テスト」を削除しました。'
      end
    end
  end
end
