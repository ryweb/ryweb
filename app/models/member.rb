class Member < Person
  using_access_control

  validates_presence_of     :address, :postcode, :city, :social_security_number
  
  STATE_NOT_MEMBER = 10
  STATE_APPLICATION = 20
  STATE_MEMBER = 30

  def self.states
    { STATE_NOT_MEMBER => 'Ei jäsen',
      STATE_APPLICATION => 'Hakee jäsenyyttä',
      STATE_MEMBER => 'Jäsen' }
  end

  def state_str
    Member.states[membership_status.to_i]
  end

  named_scope :only_members, :conditions => ["membership_status = ? AND customer_id = ?", STATE_MEMBER,Customer.current_id]
  named_scope :only_applications, :conditions => ["membership_status = ? AND customer_id = ?", STATE_APPLICATION,Customer.current_id]
end
