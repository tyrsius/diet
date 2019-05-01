'use strict'

const Airtable = require('airtable')

module.exports = {
  configure
}

function configure({ config }) {
  Airtable.configure({
    apiKey: config.apiKey
  })
  return Airtable
}
