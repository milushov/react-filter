assert   = require('assert')
chai     = require('chai')
chaiHttp = require('chai-http')
expect   = chai.expect
cheerio  = require('cheerio')
app      = require('../app/app')
url      = "http://localhost:#{app.get('port')}"


chai.use(chaiHttp)
chai.request.addPromises(require('q').Promise)

describe.only 'Filter', ->

  it 'should working', ->
    chai.request(url).get('/filter').then (res) ->
      expect(res).to.have.status(200)

  # some integration test will be here

  describe 'Api', ->

    it 'get all items', ->
      chai.request(url).get('/api/products').then (res) ->
        expect(res).to.have.status(200)

    it 'get items by category', ->
      chai.request(url).get('/api/products?categories_ids=[1,2]').then (res) ->
        expect(res).to.have.status(200)

    it 'get items by category and price', ->
      chai.request(url).get('/api/products?categories_ids=[1,2]&price=[10,200]').then (res) ->
        expect(res).to.have.status(200)

