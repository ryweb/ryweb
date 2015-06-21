class Person < CustomerData
  using_access_control

  validates_presence_of     :first_name, :surname
end
