class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2],
         password_length: 7..128

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birth_year
  validates :birth_year_id, numericality: { other_than: 0 }

  belongs_to_active_hash :birth_month
  validates :birth_month_id, numericality: { other_than: 0 }

  belongs_to_active_hash :birth_day
  validates :birth_day_id, numericality: { other_than: 0 }

  validates :nickname, :birth_day, :first_name, :last_name, :first_name_kana, :last_name_kana, :encrypted_password, :email, presence: true
  validates :first_name,
  format: {with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力してください' }
  validates :last_name,
  format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力してください' }
  validates :first_name_kana,
  format: { with: /\A([ァ-ン]|ー)+\z/, message: 'を全角カタカナで入力してください' }
  validates :last_name_kana,
  format: { with: /\A([ァ-ン]|ー)+\z/, message: 'を全角カタカナで入力してください' }

  has_one :card
  has_many :items

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    user
  end
end
