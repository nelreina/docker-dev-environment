module.exports = {
    notify: (e, operation) => {
      const { collectionName } = JSON.parse(JSON.stringify(e.record))
      console.log(`${operation} record from collection name : ${collectionName}`)
      if ("payments, payment_messages".includes(collectionName)) {
        return;
      }
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
    }
}
