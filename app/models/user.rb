class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = {
    user: 'user',
    visitor: 'visitor'
  }

  field :first_name
  field :last_name

  field :role, default: ROLES.fetch(:visitor)

  ## Database authenticatable
  field :email
  field :phone
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  belongs_to :shop
  has_many :orders

  after_update :register, if: :visitor?

  scope :visitors, -> {}

  def visitor?
    role == ROLES.fetch(:visitor)
  end

  def user?
    role == ROLES.fetch(:user)
  end

  alias_method :signed_in, :user?

  def cart
    orders.first_or_create! # TODO
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def password_required?
    false
  end

  private

  def register
    set(role: ROLES.fetch(:user)) if [:password, :password_confirmation, :email].all? {|prop| send(prop).present?}
    clean_up_passwords
  end
end