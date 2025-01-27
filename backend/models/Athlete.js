const mongoose = require('mongoose');

// Definir o esquema do atleta
const athleteSchema = new mongoose.Schema({
  athleteId: { type: Number, required: true },  // Definir athleteId corretamente como tipo número
  fullName: { type: String, required: true },
  dateOfBirth: { type: Date, required: true },
  nationality: { type: String, required: true },
  position: { type: String, required: true },
  gender: { 
    type: String,
    enum: ['Masculino', 'Feminino', 'Outro'], // Definir enum de gênero corretamente
    required: true
  }, 
  teamId: { type: Number, required: true },
  agentId: { type: Number, required: true },
  reports: { type: [Number], default: [] },
  tasks: { type: [Number], default: [] },
});

// Adiciona o middleware "pre-save" para gerar automaticamente o athleteId
athleteSchema.pre('save', async function (next) {
  if (!this.athleteId) {
    const lastAthlete = await mongoose.model('Athlete').findOne().sort({ athleteId: -1 });
    this.athleteId = Math.floor(lastAthlete ? lastAthlete.athleteId + 1 : 1); // Garantir que o ID seja um inteiro
  }
  next();
});

// Exportar o modelo Athlete
module.exports = mongoose.model('Athlete', athleteSchema);
