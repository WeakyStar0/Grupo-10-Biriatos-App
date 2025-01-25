const express = require("express");
const mongoose = require("mongoose");
const app = express();

mongoose.connect("mongodb://127.0.0.1:27017/sportsDB", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

app.use(express.json());

// Schemas e Models
const teamSchema = new mongoose.Schema({
  name: String,
});

const athleteSchema = new mongoose.Schema({
  name: String,
  teamId: { type: mongoose.Schema.Types.ObjectId, ref: "Team" },
});

const Team = mongoose.model("Team", teamSchema);
const Athlete = mongoose.model("Athlete", athleteSchema);

// Rotas
app.post("/teams", async (req, res) => {
  try {
    const { name } = req.body;
    if (!name) return res.status(400).json({ error: "Team name is required" });

    const team = new Team({ name });
    await team.save();
    res.status(201).json(team);
  } catch (error) {
    res.status(500).json({ error: "Failed to create team" });
  }
});

app.get("/teams", async (req, res) => {
  try {
    const teams = await Team.find();
    res.status(200).json(teams);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch teams" });
  }
});

app.post("/athletes", async (req, res) => {
  try {
    const { name, teamId } = req.body;
    if (!name || !teamId)
      return res.status(400).json({ error: "Name and teamId are required" });

    const teamExists = await Team.findById(teamId);
    if (!teamExists)
      return res.status(404).json({ error: "Team not found" });

    const athlete = new Athlete({ name, teamId });
    await athlete.save();
    res.status(201).json(athlete);
  } catch (error) {
    res.status(500).json({ error: "Failed to create athlete" });
  }
});

app.get('/teams/:teamId/athletes', async (req, res) => {
  const teamId = parseInt(req.params.teamId); // Converte o parâmetro para número
  try {
    const athletes = await Athlete.find({ teamId }); // Filtra os atletas pelo `teamId`
    res.status(200).json(athletes);
  } catch (error) {
    console.error('Erro ao buscar atletas do time:', error);
    res.status(500).json({ error: 'Erro ao buscar atletas do time.' });
  }
});


// Porta do servidor
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
