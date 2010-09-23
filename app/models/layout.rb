class Layout < CustomerData
  has_many :pages

  validates_presence_of :name, :content
end
