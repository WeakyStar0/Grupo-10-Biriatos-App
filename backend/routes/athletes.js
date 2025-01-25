const express = require('express');
const router = express.Router();
const Athlete = require('../models/Athlete');

// Criar um novo atleta
router.post('/', async (req, res) => {
  try {
    const athlete = new Athlete(req.body);
    await athlete.save();
    res.status(201).send(athlete);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Obter todos os atletas
router.get('/', async (req, res) => {
  try {
    const athletes = await Athlete.find();
    res.status(200).send(athletes);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Obter um atleta pelo ID
router.get('/:athleteId', async (req, res) => {
  try {
    const athlete = await Athlete.findOne({ athleteId: req.params.athleteId });
    if (!athlete) {
      return res.status(404).send({ message: 'Atleta não encontrado.' });
    }
    res.status(200).send(athlete);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Atualizar um atleta
router.put('/:athleteId', async (req, res) => {
  try {
    const athlete = await Athlete.findOneAndUpdate({ athleteId: req.params.athleteId }, req.body, { new: true });
    if (!athlete) {
      return res.status(404).send({ message: 'Atleta não encontrado.' });
    }
    res.status(200).send(athlete);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Deletar um atleta
router.delete('/:athleteId', async (req, res) => {
  try {
    const athlete = await Athlete.findOneAndDelete({ athleteId: req.params.athleteId });
    if (!athlete) {
      return res.status(404).send({ message: 'Atleta não encontrado.' });
    }
    res.status(200).send({ message: 'Atleta deletado com sucesso.' });
  } catch (error) {
    res.status(500).send(error);
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


module.exports = router;
