class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :cpf_or_cpnj
  validates :name, :registration_number, :balance, :full_adress, presence: true
  validates :registration_number, uniqueness: true
  validates :balance, numericality: true


  
  
  def cpf_or_cpnj
    cpf_reg = /\A\d{3}\.\d{3}\.\d{3}-\d\d\z/
    cpnj_reg = %r/\A\d{2}\.\d{3}\.\d{3}\/000[1-2]-\d{2}\z/
    return if registration_number && (registration_number.match(cpf_reg) || registration_number.match(cpnj_reg))   
    
    errors.add(:registration_number, ' possui formato inválido')
  end

end