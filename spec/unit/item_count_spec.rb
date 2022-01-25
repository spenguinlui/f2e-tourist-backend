require 'rails_helper'
require_relative "../../app/lib/Item_count.rb"

RSpec.describe ItemCount do
  describe "過濾機制" do
    it "必須要有內容" do
      item_count = ItemCount.new("".to_json)
      item_count.check_body
      expect(item_count.json).to eq '無內容請求'
    end
    it "必須是陣列" do
      item_count = ItemCount.new("xxx".to_json)
      item_count.check_body
      expect(item_count.json).to eq '必須是陣列'
    end
    it "必須符合 ptx ID 格式" do
      item_count = ItemCount.new(['C3_315081000H_020111', 'xx'].to_json)
      item_count.check_body
      expect(item_count.json).to eq '必須是 PTX ID 陣列'
    end
  end

  describe "無資料新增" do
    after(:each) do
      LocalItem.destroy_all
    end
    it "add_search + 1" do
      item_count = ItemCount.new(['C3_315081000H_020111'].to_json)
      item_count.check_body
      item_count.find_or_create("add_search")
      new_item = LocalItem.find_by_ptx_data_id('C3_315081000H_020111')
      expect(new_item.search_count).to eq 1
    end
    it "add_enter + 1" do
      item_count = ItemCount.new(['C3_315081000H_020111'].to_json)
      item_count.check_body
      item_count.find_or_create("add_enter")
      new_item = LocalItem.find_by_ptx_data_id('C3_315081000H_020111')
      expect(new_item.enter_count).to eq 1
    end
    it "add_favorite + 1" do
      item_count = ItemCount.new(['C3_315081000H_020111'].to_json)
      item_count.check_body
      item_count.find_or_create("add_favorite")
      new_item = LocalItem.find_by_ptx_data_id('C3_315081000H_020111')
      expect(new_item.favorite_count).to eq 1
    end
    it "remove_favorite - 1" do
      item_count = ItemCount.new(['C3_315081000H_020111'].to_json)
      item_count.check_body
      item_count.find_or_create("remove_favorite")
      new_item = LocalItem.find_by_ptx_data_id('C3_315081000H_020111')
      expect(new_item.favorite_count).to eq 0
    end
  end
  describe "有資料更新" do
    before(:each) do
      LocalItem.create!(ptx_data_id: 'C3_315081000H_020111', search_count: 1, enter_count: 1, favorite_count: 1)
    end
    after(:each) do
      LocalItem.destroy_all
    end
    it "add_search + 1" do
      item_count = ItemCount.new(['C3_315081000H_020111'].to_json)
      item_count.check_body
      item_count.find_or_create("add_search")
      new_item = LocalItem.find_by_ptx_data_id('C3_315081000H_020111')
      expect(new_item.search_count).to eq 2
    end
    it "add_enter + 1" do
      item_count = ItemCount.new(['C3_315081000H_020111'].to_json)
      item_count.check_body
      item_count.find_or_create("add_enter")
      new_item = LocalItem.find_by_ptx_data_id('C3_315081000H_020111')
      expect(new_item.enter_count).to eq 2
    end
    it "add_favorite + 1" do
      item_count = ItemCount.new(['C3_315081000H_020111'].to_json)
      item_count.check_body
      item_count.find_or_create("add_favorite")
      new_item = LocalItem.find_by_ptx_data_id('C3_315081000H_020111')
      expect(new_item.favorite_count).to eq 2
    end
    it "remove_favorite - 1" do
      item_count = ItemCount.new(['C3_315081000H_020111'].to_json)
      item_count.check_body
      item_count.find_or_create("remove_favorite")
      new_item = LocalItem.find_by_ptx_data_id('C3_315081000H_020111')
      expect(new_item.favorite_count).to eq 0
    end
  end
end