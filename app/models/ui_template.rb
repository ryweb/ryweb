class UiTemplate < ActiveRecord::Base
      has_many :customers

      validates_presence_of :name, :content
end
