require 'rails_helper'

RSpec.describe "Task 7: タスク並び替え", type: :system do
  describe "並び替えボタン" do
    let!(:task1) { create(:task, title: "タスク1", position: 1) }
    let!(:task2) { create(:task, title: "タスク2", position: 2) }

    before do
      visit tasks_path
    end

    it "上へボタンがある" do
      expect(page).to have_button("上へ")
    end

    it "下へボタンがある" do
      expect(page).to have_button("下へ")
    end
  end

  describe "タスクの並び順" do
    let!(:task1) { create(:task, title: "並び順テスト1", position: 1) }
    let!(:task2) { create(:task, title: "並び順テスト2", position: 2) }
    let!(:task3) { create(:task, title: "並び順テスト3", position: 3) }

    it "タスクがposition順に表示される" do
      visit tasks_path

      # ページ内のテキストで順序を確認
      expect(page.text).to match(/並び順テスト1.*並び順テスト2.*並び順テスト3/m)
    end

    it "position番号が表示される" do
      visit tasks_path

      expect(page).to have_content("#1")
      expect(page).to have_content("#2")
      expect(page).to have_content("#3")
    end
  end

  describe "並び替え機能" do
    context "2つのタスクがある場合" do
      let!(:task1) { create(:task, title: "移動前タスクA", position: 1) }
      let!(:task2) { create(:task, title: "移動前タスクB", position: 2) }

      it "下へボタンで順序が入れ替わる" do
        visit tasks_path

        # 初期状態: Aが先
        expect(page.text).to match(/移動前タスクA.*移動前タスクB/m)

        # 下へボタンをクリック（最初のタスクの下へボタン）
        click_button "下へ", match: :first

        # 移動後: Bが先になる
        expect(page).to have_content("タスク一覧")
        expect(page.text).to match(/移動前タスクB.*移動前タスクA/m)
      end
    end
  end

  describe "上へ移動機能" do
    let!(:task1) { create(:task, title: "上移動テストX", position: 1) }
    let!(:task2) { create(:task, title: "上移動テストY", position: 2) }

    it "上へボタンで順序が入れ替わる" do
      visit tasks_path

      # 初期状態: Xが先
      expect(page.text).to match(/上移動テストX.*上移動テストY/m)

      # 上へボタンをクリック（最後のタスクの上へボタン = 有効な上へボタン）
      # 最初の上へボタンは無効なので、:firstではなく有効なものをクリック
      click_button "上へ", disabled: false

      # 移動後: Yが先になる
      expect(page).to have_content("タスク一覧")
      expect(page.text).to match(/上移動テストY.*上移動テストX/m)
    end
  end
end
