require 'rails_helper'

RSpec.describe "Task 4: タスク詳細", type: :system do
  describe "タスク詳細画面" do
    let!(:task) { create(:task, title: "詳細表示タスク", description: "タスクの詳細な説明文です", position: 1) }

    before do
      visit task_path(task)
    end

    it "タスクのタイトルが表示される" do
      expect(page).to have_content("詳細表示タスク")
    end

    it "タスクの説明が表示される" do
      expect(page).to have_content("タスクの詳細な説明文です")
    end

    it "position番号が表示される" do
      expect(page).to have_content("#1")
    end

    it "一覧に戻るリンクがある" do
      expect(page).to have_link("一覧に戻る")
    end

    it "編集リンクがある" do
      expect(page).to have_link("編集")
    end

    it "削除ボタンがある" do
      expect(page).to have_button("削除")
    end

    it "サブタスクセクションがある" do
      expect(page).to have_content("サブタスク")
    end

    it "新規サブタスク作成リンクがある" do
      expect(page).to have_link("新規サブタスク作成")
    end
  end

  describe "説明がない場合" do
    let!(:task) { create(:task, title: "説明なしタスク", description: nil) }

    before do
      visit task_path(task)
    end

    it "タスクのタイトルが表示される" do
      expect(page).to have_content("説明なしタスク")
    end
  end

  describe "一覧画面からの遷移" do
    let!(:task) { create(:task, title: "遷移テストタスク") }

    it "一覧からタスクタイトルをクリックして詳細に遷移できる" do
      visit tasks_path
      click_link "遷移テストタスク"

      expect(page).to have_current_path(task_path(task))
      expect(page).to have_content("遷移テストタスク")
    end
  end

  describe "一覧への戻り" do
    let!(:task) { create(:task, title: "戻りテストタスク") }

    it "一覧に戻るリンクで一覧画面に戻れる" do
      visit task_path(task)
      click_link "一覧に戻る"

      expect(page).to have_current_path(tasks_path)
    end
  end
end
