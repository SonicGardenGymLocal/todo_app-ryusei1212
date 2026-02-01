require 'rails_helper'

RSpec.describe "Task 1: ホーム画面", type: :system do
  describe "ホーム画面の表示" do
    before do
      visit root_path
    end

    it "タイトルが表示される" do
      expect(page).to have_content("タスク管理アプリ")
    end

    it "ウェルカムメッセージが表示される" do
      expect(page).to have_content("タスク管理アプリへようこそ")
    end

    it "説明文が表示される" do
      expect(page).to have_content("このアプリケーションでタスクを管理できます")
    end

    it "タスク一覧へのリンクが表示される" do
      expect(page).to have_link("タスク一覧へ")
    end
  end

  # describe "ナビゲーション" do
  #   before do
  #     visit root_path
  #   end
  #
  #   it "ホームリンクがある" do
  #     expect(page).to have_link("ホーム")
  #   end
  #
  #   it "タスク一覧リンクがある" do
  #     expect(page).to have_link("タスク一覧")
  #   end
  #
  #   it "タスク一覧へのボタンをクリックするとタスク一覧ページに遷移する" do
  #     click_link "タスク一覧へ"
  #     expect(page).to have_current_path(tasks_path)
  #   end
  # end
end
