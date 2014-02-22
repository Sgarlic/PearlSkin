class User < ActiveRecord::Base
  has_many :comments

  has_many :useds, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :favourites, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def used?(item_id)
    useds.find_by(item_id:item_id)
  end

  def used!(item_id)
    useds.create!(item_id:item_id)
  end

  def unused!(item_id)
    useds.find_by(item_id:item_id).destroy
  end

  def plan?(item_id)
    plans.find_by(item_id:item_id)
  end

  def plan!(item_id)
    plans.create!(item_id:item_id)
  end

  def unplan!(item_id)
    plans.find_by(item_id:item_id).destroy
  end

  def favourite?(item_id)
    favourites.find_by(item_id:item_id)
  end

  def favourite!(item_id)
    favourites.create!(item_id:item_id)
  end

  def unfavourite!(item_id)
    favourites.find_by(item_id:item_id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
