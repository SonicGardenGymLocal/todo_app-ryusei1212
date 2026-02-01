require 'rails_helper'

RSpec.describe "Task 2: タスク作成", type: :system do
  describe "新規タスク作成画面" do
    before do
      visit new_task_path
    end

    it "タイトルが表示される" do
      expect(page).to have_content("新規タスク作成")
    end

    it "タイトル入力フィールドがある" do
      expect(page).to have_field("タイトル")
    end

    it "説明入力フィールドがある" do
      expect(page).to have_field("説明")
    end

    it "戻るリンクがある" do
      expect(page).to have_link("一覧に戻る")
    end
  end

  describe "タスク作成" do
    before do
      visit new_task_path
    end

    context "有効なデータの場合" do
      it "タスクを作成できる" do
        fill_in "タイトル", with: "新しいタスク"
        fill_in "説明", with: "タスクの説明文"
        click_button "作成"

        expect(page).to have_content("タスクを作成しました")
        expect(page).to have_current_path(tasks_path)
      end

      it "説明なしでもタスクを作成できる" do
        fill_in "タイトル", with: "説明なしタスク"
        click_button "作成"

        expect(page).to have_content("タスクを作成しました")
      end
    end

    context "無効なデータの場合" do
      it "タイトルが空の場合エラーが表示される" do
        fill_in "タイトル", with: ""
        click_button "作成"

        expect(page).to have_content("エラーがあります")
        expect(page).to have_content("を入力してください")
      end
    end
  end

  describe "positionの自動設定" do
    it "最初のタスクはposition 1で作成される" do
      visit new_task_path
      fill_in "タイトル", with: "最初のタスク"
      click_button "作成"

      expect(page).to have_content("タスクを作成しました")
      expect(page).to have_content("#1")
    end

    it "新しいタスクは既存の最大position+1で作成される" do
      # 最初のタスクを作成
      visit new_task_path
      fill_in "タイトル", with: "1番目のタスク"
      click_button "作成"
      expect(page).to have_content("タスクを作成しました")

      # 2番目のタスクを作成
      visit new_task_path
      fill_in "タイトル", with: "2番目のタスク"
      click_button "作成"
      expect(page).to have_content("タスクを作成しました")

      # position番号が表示されているか確認
      expect(page).to have_content("#1")
      expect(page).to have_content("#2")
    end
  end
end
