class Conversation
	include Mongoid::Document
	field :participants, type: Array
	field :location, type: Array
	field :radius, type: Integer
	field :text, type: String
	include Mongoid::Timestamps::Created
	include Mongoid::Timestamps::Updated

	belongs_to :requester, :class_name => "User", :inverse_of => nil
	embeds_many :responses, :class_name => "Message", :inverse_of => nil
end
