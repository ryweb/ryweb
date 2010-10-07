class Customer < ActiveRecord::Base
  using_access_control
  has_many :users
  belongs_to :ui_template

  validates_presence_of     :name
  validates_presence_of     :title

  def self.current
    Thread.current['customer']
  end

  def self.current_id
    unless Customer.current.nil?
      Customer.current.id
    else
      nil
    end
  end

  def self.current=(customer)
    cust = nil
    case customer
    when Integer
      cust = Customer.find(customer)
    when String
      cust = Customer.find_by_name(customer)
    when Customer
      cust = customer
    when nil
      cust = nil
    end
    Thread.current['customer'] = cust
  end

  def getOptionsForSelectList(method)
   case method
     when :language
       @options = {
         'suomi' => 'fi',
         'Русский' => 'ru',
       }
   end
  end

  def self.campgrounds
    {10 => 'Hankasalmi',
     20 => 'Kallio',
     30 => 'Kuusamo',
     40 => 'Maitoinen',
     50 => 'Rautiosaari',
     60 => 'Siikatörmä',
     }
  end

  def campground_str
    Customer.campgrounds[power_base]
  end

  def self.target_areas
    {
        10 => 'Lappi',
        20 => 'Koillismaa',
        30 => 'Pohjois-Pohjanmaa',
        40 => 'Kainuu',
        50 => 'Keski-Pohjanmaa',
        60 => 'Etelä-Pohjanmaa',
        70 => 'Keski-Suomi',
        80 => 'Savo',
        90 => 'Pohjois-Karjala',
        100 => 'Länsi-Suomi',
        110 => 'Häme',
        120 => 'Etelä-Karjala',
        130 => 'Helsinki',
        140 => 'SRK:n ulkolähetys',
    }
  end

  def target_area_str
    Customer.target_ares[target_area]
  end

  def getcampurl(campground)
          first = 'https://www.leirille.fi/leiri/'
          last = '/?rss=1'
    case campground
    when 10
      middle = 'hankasalmi'
    when 20
      middle = 'kallio'
    when 30
      middle = 'Kuusamo'
    when 40
      middle = 'maitoinen'
    when 50
      middle = 'rautiosaari'
    when 60
      middle = 'siikatorma'
    end

    return first + middle + last
  end

end
