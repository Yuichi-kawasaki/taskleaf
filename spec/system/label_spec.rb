require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  before do
    @label = FactoryBot.create(:label)
    @label2 = FactoryBot.create(:label2)
    @label3 = FactoryBot.create(:label3)
    @user = FactoryBot.create(:user)
    @admin_user = FactoryBot.create(:admin_user)
    @task1 = FactoryBot.create(:task, name: 'task1', user: @admin_user)
    @task2 = FactoryBot.create(:second_task, name: 'task2', user: @admin_user)
    @labelling = FactoryBot.create(:labelling, task: @task1, label: @label)
    visit new_session_path
    fill_in 'Email',with: 'admin@admin.com'
    fill_in 'Password',with: '00000000'
    click_button 'ログイン'
  end

  context 'ラベルを検索した場合'do
    it '選択したラベルを含むタスクが表示される'do
      visit tasks_path
      select '新規',from: 'label_id'
      click_button 'Search'
      expect(page).to have_content 'task1'
    end
  end

  context 'タイトルをあいまい検索し,かつラベルを検索した場合'do
    it '入力値を含むタスクが表示され、かつ選択したラベルを含むタスクが表示される'do
      visit tasks_path
      fill_in 'タイトル検索',with: 'task1'
      select '新規',from: 'label_id'
      click_button 'Search'
      expect(page).to have_content 'task1'
      expect(page).to have_content '新規'
    end
  end

  context 'ステータスを検索し,かつラベルを検索した場合'do
    it '入力値を含むタスクが表示され、かつ選択したステータスとラベルを含むタスクが表示される'do
      visit tasks_path
      fill_in 'タイトル検索',with: 'task1'
      select '未着手',from: 'ステータス検索'
      select '新規',from: 'label_id'
      click_button 'Search'
      expect(page).to have_content 'task1'
      expect(page).to have_content '未着手'
      expect(page).to have_content '新規'
    end
  end
end
