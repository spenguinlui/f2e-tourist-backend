require 'rails_helper'

RSpec.describe Api::V1::HotsController, type: :controller do
  describe "index" do
    before(:all) do
      LocalItem.destroy_all
      Setting.destroy_all
      Setting.create(attribute_name: "search_weight", attribute_value: "0.1")
      Setting.create(attribute_name: "enter_weight", attribute_value: "1")
      Setting.create(attribute_name: "favorite_weight", attribute_value: "1.5")
      LocalItem.create!(ptx_data_id: 'C3_315081000H_020111', search_count: 10, enter_count: 1, favorite_count: 1)
      LocalItem.create!(ptx_data_id: 'C3_315081100H_000001', search_count: 1, enter_count: 5, favorite_count: 1)
      LocalItem.create!(ptx_data_id: 'C3_315081100H_000002', search_count: 1, enter_count: 1, favorite_count: 5)
    end

    it "正確排名資料" do
      get :index, xhr: true, :params => { top: 1 }
      expect(JSON.parse(response.body)).to eq ['C3_315081100H_000002']
    end

    it "換頁正常" do
      get :index, xhr: true, :params => { top: 1, skip: 1 }
      expect(JSON.parse(response.body)).to eq ['C3_315081100H_000001']
    end
  end
end