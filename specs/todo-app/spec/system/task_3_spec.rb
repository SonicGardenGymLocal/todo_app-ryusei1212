require 'rails_helper'

RSpec.describe "Task 3: タスク一覧", type: :system do
  describe "タスク一覧画面" do
    context "タスクがない場合" do
      before do
        visit tasks_path
      end

      it "タイトルが表示される" do
        expect(page).to have_content("タスク一覧")
      end

      it "新規タスク作成ボタンがある" do
        expect(page).to have_link("新規タスク作成")
      end

      it "タスクがない旨のメッセージが表示される" do
        expect(page).to have_content("タスクがありません")
      end
    end

    context "タスクがある場合" do
      let!(:task1) { create(:task, title: "タスク1", position: 1) }
      let!(:task2) { create(:task, title: "タスク2", position: 2) }
      let!(:task3) { create(:task, title: "タスク3", position: 3) }

      before do
        visit tasks_path
      end

      it "全てのタスクが表示される" do
        expect(page).to have_content("タスク1")
        expect(page).to have_content("タスク2")
        expect(page).to have_content("タスク3")
      end

      it "タスクがposition順に表示される" do
        # ページ内のテキストで順序を確認
        expect(page.text).to match(/タスク1.*タスク2.*タスク3/m)
      end

      it "各タスクに詳細リンクがある" do
        expect(page).to have_link("詳細", count: 3)
      end

      it "各タスクに編集リンクがある" do
        expect(page).to have_link("編集", count: 3)
      end

      it "各タスクに削除ボタンがある" do
        expect(page).to have_button("削除", count: 3)
      end

      it "position番号が表示される" do
        expect(page).to have_content("#1")
        expect(page).to have_content("#2")
        expect(page).to have_content("#3")
      end
    end
  end

  describe "新規タスク作成への遷移" do
    before do
      visit tasks_path
    end

    it "新規タスク作成ボタンをクリックすると作成画面に遷移する" do
      click_link "新規タスク作成"
      expect(page).to have_current_path(new_task_path)
    end
  end

  describe "タスク詳細への遷移" do
    let!(:task) { create(:task, title: "詳細確認用タスク") }

    before do
      visit tasks_path
    end

    it "タスクタイトルをクリックすると詳細画面に遷移する" do
      click_link "詳細確認用タスク"
      expect(page).to have_current_path(task_path(task))
    end

    it "詳細ボタンをクリックすると詳細画面に遷移する" do
      click_link "詳細"
      expect(page).to have_current_path(task_path(task))
    end
  end
end
