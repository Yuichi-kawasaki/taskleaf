require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスクモデル機能', type: :model do
    describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
      @task1 = FactoryBot.create(:task, name: 'task1', user_id: @user.id)
      @task2 = FactoryBot.create(:second_task, name: 'task2', user_id: @user.id)
      @task3 = FactoryBot.create(:second_task, name: 'task3', user_id: @admin_user.id)
    end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.get_by_name('task1')).to include(@task1)
        expect(Task.get_by_name('task1')).not_to include(@task2)
        expect(Task.get_by_name('task1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        expect(Task.get_by_status('未着手')).to include(@task1)
        expect(Task.get_by_status('未着手')).not_to include(@task2)
        expect(Task.get_by_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        expect(Task.get_by_name('task1').get_by_status('未着手')).to include(@task1)
        expect(Task.get_by_name('task1').get_by_status('未着手')).not_to include(@task2)
        expect(Task.get_by_name('task1').get_by_status('未着手').count).to eq 1
      end
    end
  end
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do

          task = Task.new(name: '', limit_on: '2020-12-12', status: '未着手')
          expect(task).not_to be_valid
        end
      end

      context 'タスクの期限が空の場合' do
        it 'バリデーションにひっかかる' do
          # ここに内容を記載する
          task = Task.new(name: 'task', limit_on: '', status: '未着手')
          expect(task).not_to be_valid
        end
      end

      context 'タスクのステイタスが空の場合' do
        it 'バリデーションにひっかかる' do
          # ここに内容を記載する
          task = Task.new(name: 'task', limit_on: '2020-12-12', status: '')
          expect(task).not_to be_valid
        end
      end

      context 'タスクのタイトルと期限とステイタスに内容が記載されている場合' do
        it 'バリデーションが通る' do
          # binding.irb
          @user = FactoryBot.create(:user)

          task = Task.new(name: 'task', limit_on: '2020-12-12', status: '未着手', user_id: @user.id)
          expect(task).to be_valid
        end
      end
    end
  end
end
