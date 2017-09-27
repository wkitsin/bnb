class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations
	mount_uploaders :photos, PhotoUploader
	scope :category, -> (category) { category.blank? ? all : where("category ilike ?",  "%#{category}%")}
	scope :guest, -> (guest) { guest.blank? ? all : where(number_of_guest: guest)}
	scope :general, -> (general) { 
		if general.blank? 
			all
		else 
			# keyword = general.split
			# query = ["title ilike ? or location ilike ?"] * keyword.count
			# joined = query.join(' or ')
			# a = (keyword.map { |i| ["%#{i}%"]*query.count }).flatten

			# where([joined] +  a)

			relation = Listing.where(id: 0)
			general.split.each do |j|
				relation = relation.or(Listing.where("title ilike ? or location ilike ?", "%#{j}%", "%#{j}%"))
			end 
			relation
			byebug 
		end 	
	}
	scope :type, -> (type) { type.blank? ? all : where(type_of_room: type)}

end
