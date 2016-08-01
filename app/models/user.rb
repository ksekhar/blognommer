class User < ApplicationRecord
  enum role: [:visitor, :blogger, :admin]
  after_initialize :set_default_role, if: -> { new_record? }

  has_many :blogs, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :nullify

  def set_default_role
    self.role ||= :blogger
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
