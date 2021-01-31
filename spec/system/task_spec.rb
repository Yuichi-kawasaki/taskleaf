require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin_user = FactoryBot.create(:admin_user)
    @task1 = FactoryBot.create(:task, name: 'task1', user_id: @admin_user.id)
    @task2 = FactoryBot.create(:second_task, name: 'task2', user_id: @admin_user.id)
    visit new_session_path
    fill_in 'Email',with: 'admin@admin.com'
    fill_in 'Password',with: '00000000'
    click_button 'ログイン'
  end

  describe '検索機能'do
    context 'タイトルをあいまい検索した場合'do
      it '入力値を含むタスクが表示される'do
      visit tasks_path
      fill_in 'タイトル検索',with: 'task1'
      click_button 'Search'
      # sleep 0.5
      expect(page).to have_content 'task1'
      expect( Task.count ).to eq 2
    end
  end
  context 'ステータスを検索した場合'do
    it '選択したステータスを含むタスクが表示される'do
    visit tasks_path
    select '未着手',from: 'ステータス検索'
    click_button 'Search'
    expect(page).to have_content '未着手'
    end
  end
  context 'タイトルをあいまい検索し,かつステータスを検索した場合'do
    it '入力値を含むタスクが表示され、かつ選択したステータスを含むタスクが表示される'do
    visit tasks_path
    fill_in 'タイトル検索',with: 'task1'
    select '未着手',from: 'ステータス検索'
    click_button 'Search'
    expect(page).to have_content 'task1'
    expect(page).to have_content '未着手'
    end
   end
end
describe '新規作成機能' do
  context 'タスクを新規作成した場合' do
    it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'Name',with: 'task1'
      select '未着手',from: 'ステータス'
      select '低',from: '優先順位'
      click_button 'commit'
      visit tasks_path
      expect(page).to have_content 'task1'
      expect(page).to have_content '2020'
      expect(page).to have_content '11'
      expect(page).to have_content '12'
      expect(page).to have_content '未着手'
      expect(page).to have_content '低'
      # expect(page).to have_content 'task_failure'
    end
  end
  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      # ここに実装する
      visit tasks_path

      task_list = all('tbody tr')
      expect(task_list[0]).to have_content 'task2'
      expect(task_list[1]).to have_content 'task1'
    end
  end
end
describe '一覧表示機能' do
  context '一覧画面に遷移した場合' do
    it '作成済みのタスク一覧が表示される' do
      # task = FactoryBot.create(:task, name: 'task')
      visit tasks_path

      expect(page).to have_content 'task1'
    end
  end
  context 'タスク終了期限でソートした場合' do
    it '終了期限降順で表示される' do
      # ここに実装する
      visit tasks_path

      click_on '終了期限でソートする'
      sleep 0.5
      task_list = all('tbody tr')
      expect(task_list[0]).to have_content '2020-12-22'
      expect(task_list[1]).to have_content '2020-11-12'
    end
  end
  context '優先順位が高い順でソートした場合' do
    it '優先順位降順で表示される' do
      # ここに実装する
      visit tasks_path

      click_on '優先順位が高い順にソートする'
      sleep 0.5
      task_list = all('tbody tr')
      expect(task_list[0]).to have_content '高'
      expect(task_list[1]).to have_content '低'
    end
  end
end
describe '詳細表示機能' do
  context '任意のタスク詳細画面に遷移した場合' do
    it '該当タスクの内容が表示される' do
      # @task = FactoryBot.create(:task, name: 'task1')

      visit task_path(@task1)

      expect(page).to have_content 'task1'
    end
  end
end
end
