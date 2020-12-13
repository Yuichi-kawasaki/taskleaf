require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do

          task = Task.new(title: '', task_limit_on: '2020-12-12', task_status: '未')
          expect(task).not_to be_valid
        end
      end

      context 'タスクの期限が空の場合' do
        it 'バリデーションにひっかかる' do
          # ここに内容を記載する
          task = Task.new(title: 'task', task_limit_on: '', task_status: '未')
          expect(task).not_to be_valid
        end
      end

      context 'タスクのステイタスが空の場合' do
        it 'バリデーションにひっかかる' do
          # ここに内容を記載する
          task = Task.new(title: 'task', task_limit_on: '2020-12-12', task_status: '')
          expect(task).not_to be_valid
        end
      end

      context 'タスクのタイトルと期限とステイタスに内容が記載されている場合' do
        it 'バリデーションが通る' do

          task = Task.new(title: 'task', task_limit_on: '2020-12-12', task_status: '未')
          expect(task).to be_valid
        end
      end
    end
  end
end
