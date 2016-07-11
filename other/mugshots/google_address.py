google_tag = all_info.find('div', {'class':'google-map'})
if google_tag is not None:
	address_tag = google_tag.find('h2', {'class':'address'})
	if address_tag is not None:
			#print child.decode_contents(formatter="html")
		google_address = address_tag.text.strip().lower().strip('address: ')