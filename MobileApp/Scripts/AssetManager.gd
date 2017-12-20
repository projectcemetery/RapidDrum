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

func loadFile(path):
	"""
	Load file from res or user space
	
	@param path - full path to file	
	@return file as string or null if file not exists
	
	Example:
		loadFile("user://sample.wav")
	"""
	
	var file = File.new()
	if not file.file_exists(path):
		return null
	
	file.open(path, file.READ)
	return file.get_as_text()
	
func saveFile(path, data):
	"""
	Save file to user://
	
	@param path - path to file
	@param data - data of file as string
	@return void
	"""
	
	var fullPath = getFullPath(path)
	
	var file = File.new()
	file.open(fullPath, file.WRITE)
	file.store_string(data)
	file.close()
	
func getDirectoryFiles(path, fileOnly = true):
	"""
	List directory files and another directory from user://
	
	@param String path - path of directory
	@param Bool fileOnly - only files without directories
	@return Array<String> - file name array
	
	Example:
		print(getDirectoryFiles("assets/samles"))
		out: ["file1.wav", "file2.wav"]
	"""
	
	var fullPath = getFullPath(path)
	
	var dir = Directory.new()
	if not dir.dir_exists(fullPath):
		return null
		
	dir.open(fullPath)
	dir.list_dir_begin(true, true)
	var name = dir.get_next()	
	var res = []
	while(name != ""):
		var spath = "%s/%s" % [fullPath, name]
		if fileOnly and dir.dir_exists(spath):
			name = dir.get_next()
			continue
		
		res.append(spath)
		name = dir.get_next()
		
	return res;
	

func copyDirectory(src, dst):
	"""
	Copy directory recursive
	
	@param String src - full path of source directory
	@param String dst - full path of destination directory	
	@return void
	
	Example:
		copyDirectory("res://assets", "user://assets/samples")
	"""
	
	var dir = Directory.new()
	if dir.dir_exists(dst):
		return
	
	if dir.make_dir_recursive(dst) != 0:
		return
	
	dir.open(src)
	dir.list_dir_begin(true, true)
	var name = dir.get_next()
	while(name != ""):
		var spath = "%s/%s" % [src, name]
		var dpath = "%s/%s" % [dst, name]
		if dir.file_exists(spath):
			dir.copy(spath, dpath)
		elif dir.dir_exists(spath):
			copyDirectory(spath, dpath)
		name = dir.get_next()