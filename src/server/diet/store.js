'use strict'

const { BaseStore } = require('../airtable/baseStore')
const dayjs = require('dayjs')

class DietStore extends BaseStore {
  constructor({ baseId, tableName, airtable }) {
    super({ baseId, tableName, airtable, useTypeCast: true })
    this.dietLog = this.table
  }

  fromDb(record) {
    let base = super.fromDb(record)
    return {
      id: base.id,
      date: new Date(base.Date),
      weight: base.Weight,
      protien: base.Protien,
      carbs: base.Carbs,
      calories: base.Calories
    }
  }

  toDb(record) {
    return super.toDb({
      Date: dayjs(record.date).format('YYYY-MM-DD'),
      Weight: record.weight,
      Protien: record.protien,
      Carbs: record.Carbs,
      Calories: record.calories
    })
  }
}

module.exports = {
  DietStore
}
