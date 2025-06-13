// server.js
const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const cors = require("cors");

dotenv.config();

const app = express();
app.use(cors());

const PORT = process.env.PORT || 5000;

// Middleware
app.use(express.json());


// Connect to MongoDB
mongoose
    .connect(process.env.MONGODB_URI)
    .then(() => console.log("MongoDB connected successfully"))
    .catch((error) => console.error("MongoDB connection error:", error));

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
