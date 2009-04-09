class OccasionType < CustomerData
    has_many :occasions
    
  validates_presence_of     :name
  validates_presence_of     :visibility
  
  def getOptionsForSelectList(method)
   case method
     when :visibility
       @options = {
         'Sisäinen (intranet)' => 10,
         'Julkinen (internet)' => 20,
       }
   end
  end
end
