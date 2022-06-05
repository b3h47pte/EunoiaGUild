const passport = require('passport')
const { getAuth } = require('firebase-admin/auth')
const { config } = require('../config')

module.exports = (app) => {
    app.get(
        '/auth/discord',
        passport.authenticate('discord')
    )

    app.get(
        '/auth/discord/callback',
        function(req, res, next) {
            // err and user get send from the Discord strategy created in index.js.
            passport.authenticate('discord', function(err, user, info, status) {
                // Note that this is a lambda so the only thing we need to do is to redirect back to the app to finish the login
                // with a custom token that can be subsequently used to sign them in to Firebase.
                if (!!err) {
                    console.log('Failed to do authentication: ', err)
                    res.redirect(`${config.webApp}/error`)
                } else {
                    getAuth()
                        .createCustomToken(user.id, {
                            avatar: user.avatar,
                            username: user.username,
                            nick: user.nickname,
                        })
                        .then((token) => {
                            res.redirect(`${config.webApp}/login?token=${token}`)
                        })
                        .catch((error) => {
                            console.log('Failed to create custom token: ', error)
                            res.redirect(`${config.webApp}/login`)
                        })
                }
            })(req, res, next)
        },
    )
}