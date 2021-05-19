class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :products, through: :carts
  has_many :reviews, dependent: :destroy
 
  validates :first_name,  presence: true
  validates :last_name, presence: true
  validates :first_name_kana, :last_name_kana, presence: true,
  format: { with: /\A([ァ-ヶ]|ー)+\z/, message: "is must NOT contain any other characters than alphanumerics." }
  # アカウント作成時の苗字名前のカナ入力欄のカタカナのみ入力可能とするバリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #　←メールアドレスの正規表現
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  #メールアドレスを正規表現のフォームに指定
  validates :postal_code,  presence: true, format: { with: /\A\d{7}\z/ }
  # アカウント作成時の郵便番号はハイフンなしの7桁のみ登録可能とするバリデーション
  validates :address, presence: true
  validates :tell, presence: true, format: { with: /\A\d{10,11}\z/ }
  # アカウント作成時の電話番号はハイフンなしの10桁もしくは11桁のみ登録可能とするバリデーション
  before_save :downcase_email


  # 退会後のログインを禁止(deviseメソッド)
  def active_for_authentication?
    super && (self.is_valid == true)
  end
  
   # メールアドレスをすべて小文字にする
  def downcase_email
    self.email = email.downcase
  end

end
