BaseCollection = require './base'
mPerson = require '../models/person'

class Person extends BaseCollection
	
	'model': mPerson

module.exports = Person