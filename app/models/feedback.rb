#class Feedback < CustomerData
class Feedback < ActiveRecord::Base
    
  def getOptionsForSelectList(method)
   case method
     when :category
       @options = {
         'Palaute' => 10,
         'Idea/Kehitysehdotus' => 20,
         'Virhe' => 30,
       }
   end
  end

end
