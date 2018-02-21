require('babel-core/register')({
  presets: ['env']
})
global.assert = require('assert')
global.ES_SUPPORT = require('./support/es-support')
global.td = require('testdouble') // <-- a known previous devDep version!!!!
// global.pry = require('pryjs')

var CallLog = require('../src/value/call-log').default
var StubbingRegister = require('../src/value/stubbing-register').default

module.exports = {
  beforeAll: function () {
    require('./support/custom-assertions').default(assert)
  },
  beforeEach: function () {},
  afterEach: function () {
    td.reset()
    CallLog.reset()
    StubbingRegister.reset()
  },
  afterAll: function () {}
}

global.ES_SUPPORT = {
  GENERATORS: (function () {
    try {
      eval('(function* () {})') // eslint-disable-line
      return true
    } catch (e) {
      return false
    }
  })()
}