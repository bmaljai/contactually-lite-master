json.array! @contacts.each do |contact|
  json.partial! 'contact.json.jbuilder', contact: contact
end