const mongoose = require('mongoose');

const agentSchema = new mongoose.Schema({
  agentId: { type: Number, required: true, unique: true },
  agentName: { type: String, required: true },
  contactInfo: { type: String, required: true },
});

module.exports = mongoose.model('Agent', agentSchema);
