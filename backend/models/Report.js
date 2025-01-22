const mongoose = require('mongoose');

const reportSchema = new mongoose.Schema({
  reportId: { type: Number, required: true, unique: true },
  athleteId: { type: Number, required: true },
  userId: { type: Number, required: true },
  technical: { type: Number, min: 1, max: 4, required: true },
  speed: { type: Number, min: 1, max: 4, required: true },
  competitiveAttitude: { type: Number, min: 1, max: 4, required: true },
  intelligence: { type: Number, min: 1, max: 4, required: true },
  height: { type: String, enum: ['High', 'Medium', 'Low'], required: true },
  morphology: { type: String, enum: ['Ectomorph', 'Mesomorph', 'Endomorph'], required: true },
  finalRating: { type: Number, min: 1, max: 4, required: true },
  freeText: { type: String },
});

module.exports = mongoose.model('Report', reportSchema);
