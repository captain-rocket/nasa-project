const mongoose = require('mongoose');

const launchesSchema = new mongoose.Schema({
  flightNumber: {
    type: Number,
    required: true,
    /* 
   * other schema properties
   # default: 100,
   # min: 100,
   # max: 999, 
   */
  },
  mission: {
    type: String,
    required: true,
  },
  launchDate: {
    type: Date,
    required: true,
  },
  rocket: {
    type: String,
    required: true,
  },
  target: {
    type: String,
  },
  customers: [String],
  upcoming: {
    type: Boolean,
    required: true,
  },
  success: {
    type: Boolean,
    required: true,
    default: true,
  },
});

// * Connects launchesSchema with launches collection
module.exports = mongoose.model('Launch', launchesSchema);
