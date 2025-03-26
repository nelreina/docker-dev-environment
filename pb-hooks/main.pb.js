onRecordAfterCreateSuccess((e) => {
  const utils = require(`${__hooks}/utils.js`)
  utils.notify(e, "Created")
  e.next()
})

onRecordAfterUpdateSuccess((e) => {
  const utils = require(`${__hooks}/utils.js`)
  utils.notify(e, "Updated")
  e.next()
})

onRecordAfterDeleteSuccess((e) => {
  const utils = require(`${__hooks}/utils.js`)
  utils.notify(e, "Deleted")
  e.next()
})
