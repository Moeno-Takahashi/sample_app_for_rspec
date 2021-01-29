require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
  it 'タスクが有効な状態で作られ、エラーが出ないこと' do
    task = build(:task)
    expect(task).to be_valied
    expect(task.errors).to be_empty
  end
  it "タイトルがなければ無効です" do
    task_without_title = build(:task, title: "")
    expect(task_without_title).to be_invalied
    expect(task_without_title.errors[:title]).to eq ["can't be blank"]
  end
  it "ステータスがなければ無効です" do
    task_without_status = build(:task, status:  nil)
    expect(task_without_status).to be_invalied
    expect(task_without_status.errors[:status]).to eq["can't be blank"]
  end
  it "タイトルが重複していたら無効です" do
    task = create(:task)
    task_duplicate_title = build(:task, title: task.title)
    expect(task_duplicate_title).to be_invalied
    expect(task_duplicate_title.errors[:title]).to eq["has already been taken"]
  end
  it "他のタイトルなら有効です" do
    task =  create(:task)
    task_another_title = build(:task, title:'another_title')
    expect(task_another_title).to be_valied
    expect(task_with_another_title.errors).to be_empty
  end
  end
end
