class Speaker < Person
  using_access_control

  validates_presence_of   :invitation_year, :bank_account, :tax_rate

named_scope :only_speakers, :conditions => ["invitation_year not ? AND customer_id = ?", nil,Customer.current_id]
end
