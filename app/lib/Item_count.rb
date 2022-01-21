class ItemCount
  attr_accessor :json, :status

  def initialize(body)
    @body = body
    @ids = nil
    @json = ""
    @status = 400
  end

  def check_body
    unless body_string = get_body_string(@body)
      @json = '無內容請求'
    end

    unless @ids = get_ids(body_string)
      @json = '必須是 PTX ID 陣列'
    end
  end

  def find_or_create(type)
    begin
      @ids.map do |id|
        local_item = LocalItem.find_by_ptx_data_id(id)
        local_item.present? ? update_count!(local_item, type) : create_count!(id, type)
      end
      @json = '次數更改成功'
      @status = 200
    rescue Exception => e
      Rails.logger.error e
      @json = "資料庫寫入失敗 #{e}"
    end
  end

  private

  def get_body_string(body)
    begin
      body.string
    rescue Exception => e
      Rails.logger.error e
      nil
    end
  end

  def get_ids(body_string)
    begin
      JSON.parse(body_string)
    rescue Exception => e
      Rails.logger.error e
      nil
    end
  end

  def update_count!(local_item, type)
    case type
    when "add_search"
      local_item.update!(search_count: local_item.search_count + 1)
    when "add_enter"
      local_item.update!(enter_count: local_item.enter_count + 1)
    when "add_favorite"
      local_item.update!(favorite_count: local_item.favorite_count + 1)
    when "remove_favorite"
      if local_item.favorite_count > 1
        local_item.update!(favorite_count: local_item.favorite_count - 1)
      end
    end
  end

  def create_count!(id, type)
    case type
    when "add_search"
      LocalItem.create!(ptx_data_id: id, search_count: 1)
    when "add_enter"
      LocalItem.create!(ptx_data_id: id, enter_count: 1)
    when "add_favorite"
      LocalItem.create!(ptx_data_id: id, favorite_count: 1)
    when "remove_favorite"
      LocalItem.create!(ptx_data_id: id, favorite_count: 0)
    end
  end

end