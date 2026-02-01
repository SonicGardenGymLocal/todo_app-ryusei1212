require 'rails_helper'

RSpec.describe "Task 8: サブタスク", type: :system do
  let!(:task) { create(:task, title: "親タスク") }

  describe "サブタスク一覧" do
    context "サブタスクがない場合" do
      it "タスク詳細にサブタスクがない旨が表示される" do
        visit task_path(task)
        expect(page).to have_content("サブタスクがありません")
      end
    end

    context "サブタスクがある場合" do
      let!(:sub_task1) { create(:sub_task, task: task, title: "サブタスク1") }
      let!(:sub_task2) { create(:sub_task, task: task, title: "サブタスク2") }

      it "タスク詳細にサブタスクが表示される" do
        visit task_path(task)
        expect(page).to have_content("サブタスク1")
        expect(page).to have_content("サブタスク2")
      end
    end
  end

  describe "サブタスク作成" do
    describe "新規作成画面" do
      before do
        visit new_task_sub_task_path(task)
      end

      it "タイトルが表示される" do
        expect(page).to have_content("新規サブタスク作成")
      end

      it "親タスク名が表示される" do
        expect(page).to have_content("親タスク")
      end

      it "タイトル入力フィールドがある" do
        expect(page).to have_field("タイトル")
      end

      it "説明入力フィールドがある" do
        expect(page).to have_field("説明")
      end
    end

    describe "作成処理" do
      before do
        visit new_task_sub_task_path(task)
      end

      context "有効なデータの場合" do
        it "サブタスクを作成できる" do
          fill_in "タイトル", with: "新しいサブタスク"
          fill_in "説明", with: "サブタスクの説明"
          click_button "作成"

          expect(page).to have_content("サブタスクを作成しました")
          expect(page).to have_current_path(task_path(task))
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
  end

  describe "サブタスク詳細" do
    let!(:sub_task) { create(:sub_task, task: task, title: "詳細表示サブタスク", description: "サブタスクの説明文") }

    before do
      visit task_sub_task_path(task, sub_task)
    end

    it "サブタスクのタイトルが表示される" do
      expect(page).to have_content("詳細表示サブタスク")
    end

    it "サブタスクの説明が表示される" do
      expect(page).to have_content("サブタスクの説明文")
    end

    it "親タスクへのリンクがある" do
      expect(page).to have_link("親タスク")
    end

    it "編集リンクがある" do
      expect(page).to have_link("編集")
    end

    it "削除ボタンがある" do
      expect(page).to have_button("削除")
    end
  end

  describe "サブタスク編集" do
    let!(:sub_task) { create(:sub_task, task: task, title: "編集前サブタスク", description: "編集前説明") }

    describe "編集画面" do
      before do
        visit edit_task_sub_task_path(task, sub_task)
      end

      it "タイトルが表示される" do
        expect(page).to have_content("サブタスク編集")
      end

      it "現在のタイトルが入力欄に表示される" do
        expect(page).to have_field("タイトル", with: "編集前サブタスク")
      end

      it "現在の説明が入力欄に表示される" do
        expect(page).to have_field("説明", with: "編集前説明")
      end
    end

    describe "更新処理" do
      before do
        visit edit_task_sub_task_path(task, sub_task)
      end

      context "有効なデータの場合" do
        it "サブタスクを更新できる" do
          fill_in "タイトル", with: "更新後サブタスク"
          click_button "更新"

          expect(page).to have_content("サブタスクを更新しました")
          expect(page).to have_content("更新後サブタスク")
        end
      end

      context "無効なデータの場合" do
        it "タイトルを空にすると更新できない" do
          fill_in "タイトル", with: ""
          click_button "更新"

          expect(page).to have_content("エラーがあります")
        end
      end
    end
  end

  describe "サブタスク削除" do
    let!(:sub_task) { create(:sub_task, task: task, title: "削除対象サブタスク") }

    it "サブタスク詳細から削除できる" do
      visit task_sub_task_path(task, sub_task)

      accept_confirm do
        click_button "削除"
      end

      expect(page).to have_content("サブタスクを削除しました")
      expect(SubTask.find_by(id: sub_task.id)).to be_nil
    end
  end

  describe "タスク詳細からの遷移" do
    let!(:sub_task) { create(:sub_task, task: task, title: "遷移テストサブタスク") }

    it "新規サブタスク作成リンクから作成画面に遷移できる" do
      visit task_path(task)
      click_link "新規サブタスク作成"

      expect(page).to have_current_path(new_task_sub_task_path(task))
    end

    it "サブタスクタイトルから詳細画面に遷移できる" do
      visit task_path(task)
      click_link "遷移テストサブタスク"

      expect(page).to have_current_path(task_sub_task_path(task, sub_task))
    end
  end
end
