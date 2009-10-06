class Page < CustomerData
  acts_as_versioned :class_name => 'PageVersion'

  belongs_to :layout
  belongs_to :customer
  belongs_to :author, :foreign_key => :author_id, :class_name => 'User'
  def self.states
    {1 => 'Luonnos',
      2 => 'Valmis'}
  end

  def state_str
    Page.states[state]
  end

  def author_name
    return nil if author.nil?
    author.name
  end

  def self.author_name(author_id)
    usr = User.find(author_id) unless author_id.nil?
    return nil if usr.nil?
    "#{usr.name} (#{usr.login})"
  end

end
