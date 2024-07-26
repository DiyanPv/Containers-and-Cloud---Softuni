const mongoose = require("mongoose");

exports.connect = (app) => {
  const options = {
    useNewUrlParser: true,
    autoIndex: false, // Don't build indexes automatically
    maxPoolSize: 10, // Maintain up to 10 socket connections
    // Add more options as needed
  };

  const connectWithRetry = () => {
    mongoose.Promise = global.Promise;
    console.log("Connecting to MongoDB...");
    mongoose
      .connect(process.env.MONGODB_URI, options)
      .then(() => {
        console.log("MongoDB connected successfully");
        app.emit("ready");
      })
      .catch((err) => {
        console.error("Error connecting to MongoDB:", err);
        console.log("Retrying MongoDB connection in 2 seconds...");
        setTimeout(connectWithRetry, 2000);
      });
  };

  connectWithRetry();
};
