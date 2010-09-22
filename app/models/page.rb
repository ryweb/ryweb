class Page < CustomerData
  acts_as_versioned :class_name => 'PageVersion'

  before_create :set_menu_order

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
    {TYPE_NORMAL => 'Pelkkä sivu',
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

  def get_parameter_attrs(attrs)
    param_attrs = attrs.select {|p,v| p.starts_with?('parameter_')}
    attrs.delete_if {|p,v| p.starts_with?('parameter_')}
    [attrs, param_attrs]
  end

  def initialize(attrs = nil)
    param_attrs = []
    (attrs,param_attrs = get_parameter_attrs(attrs)) unless attrs.nil?
    super(attrs)
    
    param_attrs.each do |p,v|
      __send__("#{p}=",v)
    end
  end


  def update_attributes(attrs)
    attrs,param_attrs = get_parameter_attrs(attrs)
#    param_attrs = attrs.select {|p,v| p.starts_with?('parameter_')}
#    attrs.delete_if {|p,v| p.starts_with?('parameter_')}
    super(attrs)
    param_attrs.each do |p,v|
      __send__("#{p}=",v)
    end
  end

  def calendar?
    page_type == TYPE_CALENDAR
  end

  def show_gadgets?
    return id == default_page && page_type != TYPE_CALENDAR
  end

  def default_page
      Configuration.get_one('default_page').to_i
  end

  def method_missing(meth, *args)
    if meth.to_s.starts_with?("parameter_")
      meth_name = meth.to_s.split('_',2)[1]
      if meth_name.ends_with?('=')
        param = parameters.find_or_create_by_name(meth_name[0..-2])
        param.value = *args
        param.save
        return
      else
        param =  parameters.find(:first, :conditions => {:name => meth_name})
        return param.value unless param.nil?
        return nil
      end
    end
    super
  end

  private

  def set_menu_order
    self.menu_order = Page.maximum(:menu_order).to_i + 1
  end
end
