const mongoose = require('mongoose');

const athleteSchema = new mongoose.Schema({
  athleteId: { type: Number, required: true, unique: true },
  fullName: { type: String, required: true },
  dateOfBirth: { type: Date, required: true },
  nationality: { type: String, required: true },
  position: { type: String, required: true },
  gender: { type: String, enum: ['Male', 'Female', 'Other'], required: true },
  teamId: { type: Number, required: true },
  agentId: { type: Number, required: true },
  reports: { type: [Number], default: [] },
  tasks: { type: [Number], default: [] },
});

module.exports = mongoose.model('Athlete', athleteSchema);
