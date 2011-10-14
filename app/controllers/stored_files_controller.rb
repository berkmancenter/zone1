class StoredFilesController < ApplicationController
	def show
		@s = StoredFile.find(:id)
	end

end
