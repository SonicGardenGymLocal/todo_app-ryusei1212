require 'rails_helper'

RSpec.describe "Task 6: タスク削除", type: :system do
  describe "一覧画面からの削除" do
    let!(:task) { create(:task, title: "削除対象タスク") }

    it "削除ボタンがある" do
      visit tasks_path
      expect(page).to have_button("削除")
    end

    it "削除するとタスクが削除される" do
      visit tasks_path

      accept_confirm do
        click_button "削除"
      end

      expect(page).to have_content("タスクを削除しました")
      expect(page).not_to have_content("削除対象タスク")
    end

    it "削除後は一覧画面にリダイレクトされる" do
      visit tasks_path

      accept_confirm do
        click_button "削除"
      end

      expect(page).to have_current_path(tasks_path)
    end
  end

  describe "詳細画面からの削除" do
    let!(:task) { create(:task, title: "詳細から削除タスク") }

    it "削除ボタンがある" do
      visit task_path(task)
      expect(page).to have_button("削除")
    end

    it "削除するとタスクが削除される" do
      visit task_path(task)

      accept_confirm do
        click_button "削除"
      end

      expect(page).to have_content("タスクを削除しました")
      expect(Task.find_by(id: task.id)).to be_nil
    end
  end

  describe "確認ダイアログ" do
    let!(:task) { create(:task, title: "確認ダイアログテスト") }

    it "削除をキャンセルするとタスクは削除されない" do
      visit tasks_path

      dismiss_confirm do
        click_button "削除"
      end

      expect(page).to have_content("確認ダイアログテスト")
      expect(Task.find_by(id: task.id)).to be_present
    end
  end

  describe "サブタスクを持つタスクの削除" do
    let!(:task) { create(:task, title: "親タスク") }
    let!(:sub_task) { create(:sub_task, task: task, title: "子サブタスク") }

    it "タスクを削除するとサブタスクも削除される" do
      visit tasks_path

      accept_confirm do
        click_button "削除"
      end

      expect(page).to have_content("タスクを削除しました")
      expect(SubTask.find_by(id: sub_task.id)).to be_nil
    end
  end
end
