const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  userId: { type: Number, required: true, unique: true },
  fullName: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  role: { type: String, enum: ['Administrador', 'Utilizador', 'Outro'], required: true },
});

module.exports = mongoose.model('User', userSchema);