class Layout < CustomerData
  using_access_control
  has_many :pages

  validates_presence_of :name, :content
end
