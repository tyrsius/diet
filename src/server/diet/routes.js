'use strict'

module.exports = {
  routes: {
    getAll: async (event, { dietStore }) {
      return dietStore.getAll()
    }
  }
}