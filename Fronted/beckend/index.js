// 2️⃣ imports
require('dotenv').config()
const mongoose = require('mongoose')
const express = require('express')
const cors = require('cors')
const nodemailer = require('nodemailer')
const Razorpay = require('razorpay')
const crypto = require('crypto')

const User = require('./models/User')
const Order = require('./models/Order')

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
   RAZORPAY PAYMENT API (MongoDB + Razorpay)
===================================================== */
const razorpayInstance = new Razorpay({
    key_id: process.env.RAZORPAY_KEY_ID,
    key_secret: process.env.RAZORPAY_KEY_SECRET
})

app.post('/api/payment/create-order', async (req, res) => {
    try {
        const { amount, currency } = req.body

        const options = {
            amount: amount * 100, // exact amount in paise
            currency: currency || "INR",
            receipt: "receipt_order_" + Math.random().toString(36).substring(2, 10)
        }

        const order = await razorpayInstance.orders.create(options)
        if (!order) return res.status(500).json({ success: false, message: 'Some error occured' })

        res.json({ success: true, order })
    } catch (error) {
        console.error('Razorpay Error:', error)
        res.status(500).json({ success: false, message: 'Server error' })
    }
})

app.post('/api/payment/verify-payment', async (req, res) => {
    try {
        const {
            razorpay_order_id,
            razorpay_payment_id,
            razorpay_signature
        } = req.body

        const sign = razorpay_order_id + "|" + razorpay_payment_id
        const expectedSign = crypto
            .createHmac("sha256", process.env.RAZORPAY_KEY_SECRET)
            .update(sign.toString())
            .digest("hex")

        if (razorpay_signature === expectedSign) {
            // Save to DB
            const newOrder = new Order({
                orderId: razorpay_order_id,
                paymentId: razorpay_payment_id,
                signature: razorpay_signature,
                status: 'paid'
            })
            await newOrder.save()

            return res.json({ success: true, message: "Payment verified successfully" })
        } else {
            return res.status(400).json({ success: false, message: "Invalid signature sent!" })
        }
    } catch (error) {
        console.error('Verify Error:', error)
        res.status(500).json({ success: false, message: 'Server error' })
    }
})

/* =====================================================
   SERVER START
===================================================== */
app.listen(5000, () => {
    console.log('✅ Backend running on http://localhost:5000')
})
