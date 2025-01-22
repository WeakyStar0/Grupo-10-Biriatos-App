const mongoose = require('mongoose');

const taskSchema = new mongoose.Schema({
  taskId: { type: Number, required: true, unique: true },
  teamId: { type: Number, required: true },
  athleteId: { type: Number, required: true },
  userId: { type: Number, required: true },
  description: { type: String, required: true },
});

module.exports = mongoose.model('Task', taskSchema);
