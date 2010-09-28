class UiTemplate < ActiveRecord::Base
   using_access_control
   has_many :customers

   validates_presence_of :name, :content
end
