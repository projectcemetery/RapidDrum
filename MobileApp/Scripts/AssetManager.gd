extends Reference

func getFullPath(path, isRes = false):
	"""
	Get file name
	
	@param String path - path to file without storage type
	@param Bool isRes - load from res:// or user://
	@return String full path to file
	"""
	
	if isRes:
		return "res://%s" % path
	else:
		return "user://%s" % path
		
func getFullPathFromArray(pathArray, isRes = false):
	"""
	Get file name
	
	@param String Array<String> - path to file
	@param Bool isRes - load from res:// or user://
	@return String full path to file
	"""
	
	var res = ""
	
	for n in pathArray:
		res += n + "/"
	
	res.erase(len(res) - 1, 1)
	
	return getFullPath(res, isRes)

func loadFile(path, isRes = false):
	"""
	Load file from res or user space
	
	@param path - path to file
	@param isRes - load from res:// or user://
	@return file as string or null if file not exists
	
	Example:
		loadFile("sample.wav", true)
	"""
	
	var fullPath = getFullFilePath(path, isRes)
	
	var file = File.new()
	if not file.file_exists(fullPath):
		return null
	
	file.open(fullPath, file.READ)
	return file.get_as_text()
	
func saveFile(path, data):
	"""
	Save file to user://
	
	@param path - path to file
	@param data - data of file as string
	@return void
	"""
	
	var fullPath = getFullFilePath(path)
	
	var file = File.new()
	file.open(fullPath, file.WRITE)
	file.store_string(data)
	file.close()