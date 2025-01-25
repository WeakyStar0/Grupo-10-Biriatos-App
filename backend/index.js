const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();

// Middleware para parsing JSON
app.use(bodyParser.json());

// Conexão ao MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/scouting_database', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log('Conectado ao MongoDB');
  })
  .catch((error) => {
    console.error('Erro de conexão ao MongoDB:', error);
  });

// Schemas e Models
const userSchema = new mongoose.Schema({
  userId: { type: Number, required: true, unique: true },
  fullName: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  role: { type: String, enum: ['Administrador', 'Utilizador', 'Outro'], required: true },
});

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

const teamSchema = new mongoose.Schema({
  teamId: { type: Number, required: true, unique: true },
  teamName: { type: String, required: true, unique: true },
  teamType: { type: String, enum: ['Own', 'Shadow'], required: true },
  tasks: { type: [Number], default: [] },
});

const agentSchema = new mongoose.Schema({
  agentId: { type: Number, required: true, unique: true },
  agentName: { type: String, required: true, unique: true },
  contactInfo: { type: String, required: true },
});

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

const taskSchema = new mongoose.Schema({
  taskId: { type: Number, required: true, unique: true },
  teamId: { type: Number, required: true },
  athleteId: { type: Number, required: true },
  userId: { type: Number, required: true },
  description: { type: String, required: true },
});

// Modelos
const User = mongoose.model('User', userSchema);
const Athlete = mongoose.model('Athlete', athleteSchema);
const Team = mongoose.model('Team', teamSchema);
const Agent = mongoose.model('Agent', agentSchema);
const Report = mongoose.model('Report', reportSchema);
const Task = mongoose.model('Task', taskSchema);

// Rotas básicas
app.get('/', (req, res) => {
  res.send('API funcionando!');
});

// CRUD para usuários
app.post('/users', async (req, res) => {
  try {
    const user = new User(req.body);
    await user.save();
    res.status(201).send(user);
  } catch (error) {
    res.status(400).send(error);
  }
});

app.get('/users', async (req, res) => {
  try {
    const users = await User.find();
    res.status(200).send(users);
  } catch (error) {
    res.status(500).send(error);
  }
});

// CRUD para atletas
app.post('/athletes', async (req, res) => {
  try {
    const athlete = new Athlete(req.body);
    await athlete.save();
    res.status(201).send(athlete);
  } catch (error) {
    res.status(400).send(error);
  }
});

app.get('/athletes', async (req, res) => {
  const { teamId } = req.query;
  try {
    const athletes = await Athlete.find({ teamId: parseInt(teamId) });
    res.json(athletes);
  } catch (error) {
    res.status(500).send('Erro ao buscar atletas.');
  }
});

// CRUD para times
app.post('/teams', async (req, res) => {
  try {
    const team = new Team(req.body);
    await team.save();
    res.status(201).send(team);
  } catch (error) {
    res.status(400).send(error);
  }
});

app.get('/teams', async (req, res) => {
  try {
    const teams = await Team.find();
    res.status(200).json(teams);
  } catch (error) {
    console.error('Erro ao buscar equipes:', error);
    res.status(500).json({ error: 'Erro ao buscar equipes.' });
  }
});

app.get('/teams/:teamId/athletes', async (req, res) => {
  const teamId = parseInt(req.params.teamId);
  try {
    const athletes = await Athlete.find({ teamId });
    res.status(200).json(athletes);
  } catch (error) {
    res.status(500).json({ error: 'Erro ao buscar atletas do time' });
  }
});

// CRUD para agentes
app.post('/agents', async (req, res) => {
  try {
    const agent = new Agent(req.body);
    await agent.save();
    res.status(201).send(agent);
  } catch (error) {
    res.status(400).send(error);
  }
});

app.get('/agents', async (req, res) => {
  try {
    const agents = await Agent.find();
    res.status(200).send(agents);
  } catch (error) {
    res.status(500).send(error);
  }
});

// CRUD para relatórios
app.post('/reports', async (req, res) => {
  try {
    const report = new Report(req.body);
    await report.save();
    res.status(201).send(report);
  } catch (error) {
    res.status(400).send(error);
  }
});

app.get('/reports', async (req, res) => {
  try {
    const reports = await Report.find();
    res.status(200).send(reports);
  } catch (error) {
    res.status(500).send(error);
  }
});

// CRUD para tarefas
app.post('/tasks', async (req, res) => {
  try {
    const task = new Task(req.body);
    await task.save();
    res.status(201).send(task);
  } catch (error) {
    res.status(400).send(error);
  }
});

app.get('/tasks', async (req, res) => {
  try {
    const tasks = await Task.find();
    res.status(200).send(tasks);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Iniciar o servidor
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
