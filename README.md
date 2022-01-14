# 作品說明
服務無網站，僅為 API 模式向前端頁面提供資料串接
建立使用者、供應商、管理者等提供會員登入
針對前端向 PTX 呼叫的資料 ID，紀錄尋訪次數等，以供判斷

## 前端資源連結
https://github.com/spenguinlui/f2e-tourist-frontend

## 網站 Demo
https://spenguinlui.github.io/f2e-tourist-frontend


# 功能項目

### 角色
- User: 存放使用者喜愛列表、評論
- Supplier: 與 PTX 某筆資料配合廠商，提供補充資料讓前端頁面更豐富
- Admin: 管理者，主要用於修改關鍵字 Tag、主題、權重參數等等

### 資料
- LocalItem: 對應 PTX 景點/餐廳/住宿/活動資料的補充資料
- Comment: 對某項目的評論，有匿名與非匿名模式
- Theme: 主題，包含複數關鍵字 Tag，可用來搜尋同類型資料
- Setting: 存放影響熱門排名等權重參數設定

### 資料庫配置圖
![ERmodel](https://github.com/spenguinlui/f2e-tourist-backend/blob/master/vendor/ERmodel.jpg)

# 系統版本

ruby 2.6.6
rails 6.0.0

postgreSQL 2.4.4
devise 4.8.1
rack-cors 1.1.1
rails-i18n 7.0.1
dotenv 2.7.6