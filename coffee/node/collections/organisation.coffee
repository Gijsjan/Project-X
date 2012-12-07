BaseCollection = require './base'
mOrganisation = require '../models/organisation'

class Organisation extends BaseCollection
	
	'model': mOrganisation

module.exports = Organisation