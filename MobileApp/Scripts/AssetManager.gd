extends Reference

static func _getFullFilePath(path, isRes = false):
	"""
	Get file name
	
	@param name - path to file without storage type
	@param isRes - load from res:// or user://
	@return full path to file
	"""
	
	if isRes:
		return "res://%s" % path
	else:
		return "user://%s" % path

static func loadFile(path, isRes = false):
	"""
	Load file from res or user space
	
	@param path - path to file
	@param isRes - load from res:// or user://
	@return file as string or null if file not exists
	"""
	
	var fullPath = _getFullFilePath(path, isRes)
	
	var file = File.new()
	if not file.file_exists(fullPath):
		return null
	
	file.open(fullPath, file.READ)
	return file.get_as_text()
	
static func saveFile(path, data):
	"""
	Save file to user://
	
	@param path - path to file
	@param data - data of file as string
	@return void
	"""
	
	var fullPath = _getFullFilePath(path)
	
	var file = File.new()
	file.open(fullPath, file.WRITE)
	file.store_string(data)
	file.close()