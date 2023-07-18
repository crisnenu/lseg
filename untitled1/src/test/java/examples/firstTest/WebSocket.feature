Feature: Web Socket

  Scenario: Karate with public websocket

    * def socket = karate.webSocket('wss://ws.vi-server.org/mirror')
    * socket.send('hello!')
    * def response = socket.listen(5000)
    * print response
    * match response == 'hello!'

  Scenario: Karate with multiple websocket

    * def socket1 = karate.webSocket('wss://ws.vi-server.org/mirror')
    * def socket2 = karate.webSocket('wss://ws.vi-server.org/mirror')
    * socket1.send('hello world!')
    * socket2.send('another test')

    * def result1 = socket1.listen(5000)
    * match result1 == 'hello world!'
    * def result2 = socket2.listen(5000)
    * match result2 == 'another test'