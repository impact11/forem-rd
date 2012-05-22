module Forem
  class View
    include Mongoid::Document
    include Mongoid::Timestamps

    field :count, type: Integer, default: 0
    embedded_in :topic, :class_name => 'Forem::Topic'
    belongs_to :user, :class_name => Forem.user_class.to_s

 #   validates :topic_id, :presence => true
    def increment!(fieldname)
      self.inc(fieldname.to_sym, 1)
    end
    
  end
end
