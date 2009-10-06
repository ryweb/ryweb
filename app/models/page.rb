class Page < CustomerData
  acts_as_versioned :class_name => 'PageVersion'

  STATE_DRAFT = 1
  STATE_READY = 2

  TYPE_NORMAL = 1
  TYPE_CALENDAR = 2

  has_many :parameters, :foreign_key => :page_id, :class_name => 'PageParameter'

  belongs_to :layout
  belongs_to :customer
  belongs_to :author, :foreign_key => :author_id, :class_name => 'User'

  def self.states
    {STATE_DRAFT => 'Luonnos',
      STATE_READY => 'Valmis'}
  end

  def self.page_types
    {TYPE_NORMAL => 'Normaali',
      TYPE_CALENDAR => 'Kalenteri'}
  end

  def state_str
    Page.states[state]
  end

  def author_name
    return nil if author.nil?
    author.name
  end

  def self.author_name(author_id)
    usr = User.find(:first, :conditions => {:id => author_id}) unless author_id.nil?
    return nil if usr.nil?
    "#{usr.name} (#{usr.login})"
  end
end
