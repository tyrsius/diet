'use strict'

class BaseStore {
  constructor({ airtable, baseId, tableName, useTypeCast }) {
    this.base = airtable.base(baseId)
    this.table = this.base(tableName)
    this.useTypeCast = useTypeCast
  }

  async getAll() {
    let records = await this.table.select().all()
    // console.log('base', records.map(r => r.fields))
    return records.map(this.fromDb)
  }

  async put(record) {
    let method = record.id === undefined ? 'create' : 'replace'
    toSave = this.toDb(record)
    let update = await this.table[method](toSave, {
      typecast: useTypeCast
    })
    return record
  }

  fromDb(record) {
    return {
      id: record.id,
      ...record.fields
    }
  }

  toDb(record) {
    record = { ...record }
    delete record.id
    return record
  }
}

module.exports = {
  BaseStore
}
