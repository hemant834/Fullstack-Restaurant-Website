// 2️⃣ imports
require('dotenv').config()
const mongoose = require('mongoose')
const express = require('express')
const cors = require('cors')
const nodemailer = require('nodemailer')

const User = require('./models/User')

// 3️⃣ MongoDB connect
mongoose.connect(process.env.MONGO_URI)
    .then(() => {
        console.log('✅ MongoDB connected')
    })
    .catch((err) => {
        console.error('❌ MongoDB error:', err.message)
    })

const app = express()
app.use(cors())
app.use(express.json())

/* =====================================================
   EMAIL CONFIG (GMAIL)
===================================================== */
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'hemantkumar809499@gmail.com',
        pass: 'dcauahzvkvarnrrg'
    }
})

/* =====================================================
   REGISTER API (MongoDB)
===================================================== */
app.post('/api/register', async (req, res) => {
    const { name, email, password } = req.body

    if (!name || !email || !password) {
        return res.json({
            success: false,
            message: 'All fields required'
        })
    }

    try {
        const exists = await User.findOne({ email })
        if (exists) {
            return res.json({
                success: false,
                message: 'User already exists'
            })
        }

        const newUser = new User({
            name,
            email,
            password
        })

        await newUser.save()

        res.json({
            success: true,
            message: 'Registration successful'
        })

    } catch (error) {
        console.error(error)
        res.status(500).json({
            success: false,
            message: 'Server error'
        })
    }
})

/* =====================================================
   LOGIN API (MongoDB)
===================================================== */
app.post('/api/login', async (req, res) => {
    const { email, password } = req.body

    try {
        const user = await User.findOne({ email, password })

        if (!user) {
            return res.json({
                success: false,
                message: 'Invalid credentials'
            })
        }

        res.json({
            success: true,
            message: 'Login successful',
            user: {
                name: user.name,
                email: user.email
            }
        })

    } catch (error) {
        console.error(error)
        res.status(500).json({
            success: false,
            message: 'Server error'
        })
    }
})

/* =====================================================
   BOOK TABLE API (EMAIL SEND)  ✅ UNCHANGED
===================================================== */
app.post('/api/book-table', async (req, res) => {
    const {
        name,
        email,
        phone,
        guests,
        date,
        time,
        request
    } = req.body

    try {
        await transporter.sendMail({
            from: 'hemantkumar809499@gmail.com',
            to: email,
            subject: '🍽️ Table Reservation Confirmed',
            html: `
                <h2>Reservation Confirmed</h2>
                <p><b>Name:</b> ${name}</p>
                <p><b>Email:</b> ${email}</p>
                <p><b>Phone:</b> ${phone}</p>
                <p><b>Guests:</b> ${guests}</p>
                <p><b>Date:</b> ${date}</p>
                <p><b>Time:</b> ${time}</p>
                <p><b>Special Request:</b> ${request || 'None'}</p>
                <br/>
                <p>Thank you for booking with <b>Restodine</b> 🍽️</p>
            `
        })

        res.json({
            success: true,
            message: 'Booking confirmed. Email sent successfully!'
        })
    } catch (error) {
        console.error('Email Error:', error)
        res.json({
            success: false,
            message: 'Booking saved but email failed'
        })
    }
})

/* =====================================================
   SERVER START
===================================================== */
app.listen(5000, () => {
    console.log('✅ Backend running on http://localhost:5000')
})
