process.env.NODE_ENV = process.env.NODE_ENV || 'development'
config.public_file_server.enabled = true
const environment = require('./environment')

module.exports = environment.toWebpackConfig()
