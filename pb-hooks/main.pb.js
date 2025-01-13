/// <reference path="../pb_data/types.d.ts" />
onRecordAfterUpdateSuccess((e) => {
  const { collectionName } = JSON.parse(JSON.stringify(e.record))
  console.log("Collection updated...", collectionName)
  try {
    const res = $http.send({
      url: `http://ynohub-config-data:8000/re-cache/${collectionName}`,
      method: "POST",
      timeout: 120, // in seconds
    })
    const body = JSON.stringify(res.json)
    console.log("Response from Collection data service re-cache", body)
  } catch (error) {
    console.log(error)
  }
  e.next()
})
