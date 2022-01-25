class ItemCount
  attr_accessor :json, :status

  def initialize(body)
    @body = body
    @ids = nil
    @json = ""
    @status = 400
  end

  def check_body
    unless @body.length > 2 # \"\"
      @json = '無內容請求'
      return
    end

    @ids = get_ids(@body)
    unless @ids.instance_of? Array
      @json = '必須是陣列'
      return
    end
    
    not_ptx_id = true
    @ids.map { |id| not_ptx_id = false if id.match(/\A[C]+[1-4]{1}_{1}\d/).nil? }
    unless not_ptx_id
      @json = '必須是 PTX ID 陣列'
      return
    end
  end

  def find_or_create(type)
    begin
      @ids.map do |id|
        local_item = LocalItem.find_by_ptx_data_id(id)
        local_item.present? ? update_count!(local_item, type) : create_count!(id, type)
      end
      @status = 200
    rescue Exception => e
      Rails.logger.error e
      @json = "資料庫寫入失敗 #{e}"
    end
  end

  private

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
      if local_item.favorite_count >= 1
        local_item.update!(favorite_count: local_item.favorite_count - 1)
      end
    end
    @json = '次數更新成功'
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
    @json = '次數新增成功'
  end

end