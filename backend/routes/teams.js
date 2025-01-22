const express = require('express');
const router = express.Router();
const Team = require('../models/Team');

// Criar um novo time
router.post('/', async (req, res) => {
  try {
    const team = new Team(req.body);
    await team.save();
    res.status(201).send(team);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Obter todos os times
router.get('/', async (req, res) => {
  try {
    const teams = await Team.find();
    res.status(200).send(teams);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Obter um time pelo ID
router.get('/:teamId', async (req, res) => {
  try {
    const team = await Team.findOne({ teamId: req.params.teamId });
    if (!team) {
      return res.status(404).send({ message: 'Time não encontrado.' });
    }
    res.status(200).send(team);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Atualizar um time
router.put('/:teamId', async (req, res) => {
  try {
    const team = await Team.findOneAndUpdate({ teamId: req.params.teamId }, req.body, { new: true });
    if (!team) {
      return res.status(404).send({ message: 'Time não encontrado.' });
    }
    res.status(200).send(team);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Deletar um time
router.delete('/:teamId', async (req, res) => {
  try {
    const team = await Team.findOneAndDelete({ teamId: req.params.teamId });
    if (!team) {
      return res.status(404).send({ message: 'Time não encontrado.' });
    }
    res.status(200).send({ message: 'Time deletado com sucesso.' });
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
