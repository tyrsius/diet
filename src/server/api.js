'use strict'

const { Router } = require('lambda-router')
const { wrapContext } = require('./context')

const { routes: diets } = require('./diet/routes')

exports.handler = handler

const router = Router({
  logger: console,
  inluceErrorStack: process.env.stage !== 'prod'
})

router.get('/v1/dietlogs', diets.getAll)

async function handler(event, context) {
  context.callbackWaitsForEmptyEventLoop = false
  context = wrapContext(context)
  let result = await router.route(event, context)
  return result.response
}
