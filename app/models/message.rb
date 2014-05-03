class Message
	include Mongoid::Document
	field :text, type: String
	field :location, type: Array
	include Mongoid::Timestamps::Created
	include Mongoid::Timestamps::Updated

	index({ coordinate: "2d" }, { min: -200, max: 200 })

	belongs_to :responder, :class_name => "User", :inverse_of => nil
end
