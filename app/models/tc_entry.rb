class TcEntry < ApplicationRecord
	mount_uploader :file, TcEntryUploader
end
