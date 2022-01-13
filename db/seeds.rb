# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Theme.create(theme_name: "Rainbow Life !", theme_tags: ["彩虹", "七彩"])
Theme.create(theme_name: "賞楓秘境", theme_tags: ["楓", "紅葉"])
Theme.create(theme_name: "蝦兵蟹將、漁港風情", theme_tags: ["漁", "港", "海鮮", "海產", "蝦", "蟹", "魚"])
Theme.create(theme_name: "網美打卡熱點", theme_tags: ["網美", "拍照", "打卡", "少女"])
Theme.create(theme_name: "海岸風情", theme_tags: ["海洋", "海岸", "海景", "珊瑚"])
Theme.create(theme_name: "露營熱門", theme_tags: ["露營", "野營", "野炊", "生火"])
Theme.create(theme_name: "知名地標", theme_tags: ["燈塔", "碼頭", "鐵塔"])
Theme.create(theme_name: "回憶古早味", theme_tags: ["古早", "擔仔麵", "本土味", "眷村"])
Theme.create(theme_name: "年度活動", theme_tags: ["一年一度", "年度"])
Theme.create(theme_name: "品嚐日本風", theme_tags: ["壽司", "拉麵", "大阪燒"])
Theme.create(theme_name: "放鬆度假去！", theme_tags: ["民宿", "放鬆", "度假"])

User.create(email: "anonymous@aaa.bb", password: "xxxzzz")

Setting.create(attribute_name: "search_weight", attribute_value: "0.1")
Setting.create(attribute_name: "favorite_weight", attribute_value: "1.5")
Setting.create(attribute_name: "enter_weight", attribute_value: "1")