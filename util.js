// Taken from https://github.com/rkalis/truffle-plugin-verify/blob/master/util.js
// Thank you rkalis :)
const abort = (message, logger = console, code = 1) => {
    logger.error(message)
    process.exit(code)
}

const enforce = (condition, message, logger, code) => {
    if (!condition) abort(message, logger, code)
}

const enforceOrThrow = (condition, message) => {
    if (!condition) throw new Error(message)
}

module.exports = {
    abort,
    enforce,
    enforceOrThrow
}