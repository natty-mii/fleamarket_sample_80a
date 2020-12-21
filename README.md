## アプリ概要
誰でも簡単に売買ができる、フリーマーケットのアプリケーションを作成しました。  
下記ページで公開中です。  
http://54.150.76.193/  
※Basic認証がかかっています。  
ユーザー名: hakata  
パスワード: mentaiko    
## 機能
* 商品出品機能
* 商品検索機能
* 商品購入機能
* 商品取引機能
* 商品お気に入り機能
* マイページ機能

## 動作確認方法
* Chromeの最新版を利用してアクセスしてください。
* ただしデプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続ください。
* 接続先およびログイン情報については、上記の通りです。
* 同時に複数の方がログインしている場合に、ログインできない可能性がございます。
* 出品方法は以下の手順で確認できます。  
``` 

テストアカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品

```
* 購入方法は以下の手順で確認できます。  
```

テストアカウントでログイン→トップページから商品検索→商品選択→クレジットカード登録（上記カードを使用してください）→商品購入

```
* 確認後、ログアウト処理をお願いします。

## テストアカウント
* 購入者用
```

メールアドレス: buy2@gmail.com 
パスワード: buybuy2

```
* 購入用カード情報
```

番号： 4012888888881881
期限： 12/24
セキュリティコード：123

```
* 出品者用
```

メールアドレス名: seller2@gmail.com  
パスワード: sellerseller2

```


## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|encrypted_password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birth_year_id|integer|null: false|
|birth_month_id|integer|null: false|
|birth_day_id|integer|null: false|
|phone_number|string|null: false, unique: true, limit: 11|
|introduction|string|limit: 1000|
|icon_image|string||

### Association
- has_one :address
- has_one :card
- has_many :sns_credentials
- has_many :items
- has_many :favorites
- has_many :comments

## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user

## sns_credentialsテーブル

|Column|Type|Options|
|------|----|-------|
|provider|string|null: false|
|uid|string|null: false|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## addressesテーブル

|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|zip_code|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|block_number|string|null: false|
|apartment_name|string||
|user|references|null: false, foreign_key: true|
|phone_number|string||

### Association
- belongs_to :user

## favorite(favorite_items)テーブル

|Column|Type|Options|
|------|----|-------|
|item|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## commetns(user_commmetns)テーブル

|Column|Type|Options|
|------|----|-------|
|content|string|null: false|
|item|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, limit: 40, add_index: true|
|description|string|null: false, limit: 1000|
|category|references|null: false, foreign_key: true|
|brand|string||
|status_id|integer|null: false|
|delivery_charge_id|integer|null: false|
|prefecture_id|integer|null: false|
|delivery_date_id|integer|null: false|
|price|integer|null: false|
|trading_status_id|integer|null: false|
|user|references|null: false

### Association
- belongs_to :user
- belogns_to :category
- has_many :favorites
- has_many :comments
- has_many :images
## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item|references|null: false, foreign_key: true|

### Association
- belongs_to :item

## purchasesテーブル

|Column|Type|Options|
|------|----|-------|
|item|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user
