class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]
  has_many :sent_friendrequests, class_name:  "Friendrequest",
                                  foreign_key: "sender_id",
                                  dependent:   :destroy
  has_many :received_friendrequests, class_name:  "Friendrequest",
                                      foreign_key: "receiver_id",
                                      dependent:   :destroy
  has_many :invited_users, through: :sent_friendrequests, source: :receiver
  has_many :inviting_users, through: :received_friendrequests, source: :sender
  has_many :friendships, foreign_key: "friend_id",
                         dependent: :destroy
  has_many :friends, through: :friendships, source: :befriended
  has_many :posts, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  #after_create :send_welcome_mail
  has_one_attached :avatar

  def send_welcome_mail
    UserMailer.with(user: self).welcome_email.deliver
  end

  def post_timeline
    Post.where("user_id IN (?) OR user_id = ?", friends.ids, id)
  end

  def photo_timeline
    Photo.where("user_id IN (?) OR user_id = ?", friends.ids, id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
  end
end
