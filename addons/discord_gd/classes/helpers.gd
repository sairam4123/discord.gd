class_name Helpers
"""
General purpose Helpers functions
used by discord.gd plugin
"""

# Returns true if value if an int or real float
static func is_num(value) -> bool:
	return typeof(value) == TYPE_INT or typeof(value) == TYPE_REAL


# Returns true if value is a string
static func is_str(value) -> bool:
	return typeof(value) == TYPE_STRING


# Returns true if the string has more than 1 character
static func is_valid_str(value) -> bool:
	return is_str(value) and value.length() > 0


# Return a ISO 8601 timestamp as a String
static func make_iso_string(datetime: Dictionary = OS.get_datetime()) -> String:
	var iso_string = '%s-%02d-%02dT%02d:%02d:%02d' % [datetime.year, datetime.month, datetime.day, datetime.hour, datetime.minute, datetime.second]

	# generate correct local timezone
	var timezone = OS.get_time_zone_info()
	var zone_sign = '+' if timezone.bias > 0 else '-'
	var zone_hour = int(timezone.bias / 60)
	timezone.bias -= zone_hour * 60

	iso_string +=  '%s%02d:%02d' % [zone_sign, zone_hour, timezone.bias]
	return iso_string


# Pretty prints a Dictionary
static func print_dict(d: Dictionary):
	print(JSON.print(d, '\t'))


# Saves a Dictionary to a file for debugging large dictionaries
static func save_dict(d: Dictionary, filename = 'saved_dict'):
	assert(typeof(d) == TYPE_DICTIONARY, 'type of d is not Dictionary in save_dict')
	var file = File.new()
	file.open('user://%s%s.json' % [filename, str(OS.get_ticks_msec())], File.WRITE)
	#file.store_string(JSON.print(d, '\t'))
	file.store_line(to_json(d))
	assert(false)
	file.close()
	print('Dictionary saved to file')