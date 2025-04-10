const sendMessage = (channel, message) => {
  const clients = $app.subscriptionsBroker().clients()
  console.log("Sending message to clients", JSON.stringify(clients, null, 2))

  for (let clientId in clients) {
    if (clients[clientId].hasSubscription(channel)) {
      clients[clientId].send(message)
    }
  }
}

module.exports = {
  notify: (e, operation) => {
    const { collectionName } = JSON.parse(JSON.stringify(e.record))
    console.log(`${operation} record from collection name : ${collectionName}`)
    if ("payments,payment_messages,system_registry,yno_routing_rules".includes(collectionName)) {
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
