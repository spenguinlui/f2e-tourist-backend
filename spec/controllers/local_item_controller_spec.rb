require 'rails_helper'

RSpec.describe Api::V1::LocalItemController, type: :controller do
  describe "show" do
    before(:all) do
      LocalItem.destroy_all
      User.destroy_all
      @user = User.create!(email: "aaa@bbb.ccc", password: "xxxzzz")
      LocalItem.create!(ptx_data_id: 'C3_315081100H_000001', search_count: 1, enter_count: 1, favorite_count: 1)
      localItem = LocalItem.create!(ptx_data_id: 'C3_315081000H_020111', search_count: 10, enter_count: 1, favorite_count: 1)
      localItem.comments.create!(title: '測試標題1', score: 3, content: '測試內容1', user_id: @user.id)
      localItem.comments.create!(title: '測試標題2', score: 1, content: '測試內容2', user_id: @user.id)
    end
    it "得到指定 ID 資料" do
      get :show, xhr: true, :params => { id: 'C3_315081000H_020111' }
      expect(JSON.parse(response.body)["local_item"].present?).to be true
    end
    it "得到正確評價分數" do
      get :show, xhr: true, :params => { id: 'C3_315081000H_020111' }
      expect(JSON.parse(response.body)["average_score"]).to be 2
    end
    it "得到指定 ID 下的評論資料" do
      get :show, xhr: true, :params => { id: 'C3_315081000H_020111' }
      expect(JSON.parse(response.body)["comments"][1]["title"]).to eq "測試標題2"
    end
  end
  describe "post" do
    it "正常新增評論" do
      @user = User.last
      post :create_comment, xhr: true, :params => {
        id: 'C3_315081000H_020111', auth_token: @user.auth_token,
        title: '測試標題3',
        score: '5',
        content: '測試內容3'
      }
      expect(JSON.parse(response.body)["comments"][2]["title"]).to eq "測試標題3"
    end
    it "取得指定大量評分" do
      post :average_scores, xhr: true, :params => { ids: ['C3_315081100H_000001', 'C3_315081000H_020111'] }
      expect(JSON.parse(response.body)["average_scores"][1]["average_score"]).to be 2
    end
  end
end