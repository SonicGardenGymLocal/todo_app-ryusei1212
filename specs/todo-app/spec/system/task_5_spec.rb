require 'rails_helper'

RSpec.describe "Task 5: タスク編集", type: :system do
  let!(:task) { create(:task, title: "編集前タイトル", description: "編集前説明") }

  describe "編集画面" do
    before do
      visit edit_task_path(task)
    end

    it "タイトルが表示される" do
      expect(page).to have_content("タスク編集")
    end

    it "現在のタイトルが入力欄に表示される" do
      expect(page).to have_field("タイトル", with: "編集前タイトル")
    end

    it "現在の説明が入力欄に表示される" do
      expect(page).to have_field("説明", with: "編集前説明")
    end

    it "戻るリンクがある" do
      expect(page).to have_link("一覧に戻る")
    end
  end

  describe "タスク更新" do
    before do
      visit edit_task_path(task)
    end

    context "有効なデータの場合" do
      it "タスクを更新できる" do
        fill_in "タイトル", with: "更新後タイトル"
        fill_in "説明", with: "更新後説明"
        click_button "更新"

        expect(page).to have_content("タスクを更新しました")
        expect(page).to have_content("更新後タイトル")
      end

      it "説明を空にして更新できる" do
        fill_in "説明", with: ""
        click_button "更新"

        expect(page).to have_content("タスクを更新しました")
      end
    end

    context "無効なデータの場合" do
      it "タイトルを空にすると更新できない" do
        fill_in "タイトル", with: ""
        click_button "更新"

        expect(page).to have_content("エラーがあります")
        expect(page).to have_content("を入力してください")
      end
    end
  end

  describe "一覧画面からの遷移" do
    it "編集リンクをクリックすると編集画面に遷移する" do
      visit tasks_path
      click_link "編集"

      expect(page).to have_current_path(edit_task_path(task))
    end
  end

  describe "詳細画面からの遷移" do
    it "編集リンクをクリックすると編集画面に遷移する" do
      visit task_path(task)
      click_link "編集"

      expect(page).to have_current_path(edit_task_path(task))
    end
  end
end
