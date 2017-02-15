class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :timeoutable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  before_validation :set_slug, :set_questionaire_header, :set_questionaire_footer

  validates :email, :slug, presence: true
  validates :slug, uniqueness: true, allow_blank: true
  validates :email, uniqueness: true, allow_blank: true
  validates_email_format_of :email, check_mx: (Rails.env == "production"), message: "não é válido", allow_blank: true
  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of :password, minimum: 8, allow_blank: true
  has_attached_file :logo
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/, allow_blank: true
  validates_with AttachmentSizeValidator, attributes: :logo, less_than: 1.megabytes, allow_blank: true

  after_create :create_sample_questions!

  def needs_setup?
    (company.blank? || logo.blank?)
  end

  protected

  def password_required?
    !persisted? || !password.blank? || !password_confirmation.blank?
  end

  def set_slug
    self.slug ||= SecureRandom.hex(2)
  end

  def set_questionaire_header
    self.questionaire_header = "Sua opinião é muito importante. Ajude-nos a melhorar nossos produtos e serviços respondendo a estas questões." if questionaire_header.blank?
  end

  def set_questionaire_footer
    self.questionaire_footer = "Nenhuma informação pessoal sua será divulgada ao responder este questionário. Fique tranquilo." if questionaire_footer.blank?
  end

  def create_sample_questions!
    ["No geral, o que você achou de nós?", "O atendimento, em especial, foi satisfatório?", "Você nos recomendaria para um(a) amigo(a)?"].each do |statement|
      questions.create! statement: statement
    end
  end
end
