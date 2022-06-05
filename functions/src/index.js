const admin = require('firebase-admin')
const functions = require('firebase-functions')
const express = require('express')
const passport = require('passport')
const axios = require('axios')

const app = express()
const { config } = require('./config')
const { access } = require('fs')
const DiscordStrategy = require('passport-discord').Strategy

const EUNOIA_GUILD_ID = '610700580985503745'

passport.use(new DiscordStrategy(
    config.discord,
    async function(accessToken, refreshToken, profile, cb) {
        // Don't really need to keep the access token and refresh token around.
        // Check if the user is in the Eunoia guild.
        for (let g of profile.guilds) {
            if (g.id === EUNOIA_GUILD_ID) {
                // Need to get the guild nickname.
                try {
                    let resp = await axios.get(`https://discord.com/api/users/@me/guilds/${EUNOIA_GUILD_ID}/member`, {
                        headers: {
                            'Authorization': `Bearer ${accessToken}`
                        }
                    })

                    profile.nickname = resp.data.nick || profile.username
                    return cb(null, profile)
                } catch (ex) {
                    return cb(ex, null)
                }
            }
        }
        
        return cb(new Error('Not in Eunoia'), null)
    }
))

app.use(require('cookie-parser')())
app.use(
    require('express-session')({
        secret: config.sessionSecret,
        resave: false,
        saveUninitialized: false,
    })
)

app.use(passport.initialize())
app.use(passport.session())

require('./routes/discordAuth')(app)

admin.initializeApp()
exports.api = functions.https.onRequest(app)