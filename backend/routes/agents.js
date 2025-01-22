const express = require('express');
const router = express.Router();
const Agent = require('../models/Agent');

// Criar um novo agente
router.post('/', async (req, res) => {
  try {
    const agent = new Agent(req.body);
    await agent.save();
    res.status(201).send(agent);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Obter todos os agentes
router.get('/', async (req, res) => {
  try {
    const agents = await Agent.find();
    res.status(200).send(agents);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Obter um agente pelo ID
router.get('/:agentId', async (req, res) => {
  try {
    const agent = await Agent.findOne({ agentId: req.params.agentId });
    if (!agent) {
      return res.status(404).send({ message: 'Agente não encontrado.' });
    }
    res.status(200).send(agent);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Atualizar um agente
router.put('/:agentId', async (req, res) => {
  try {
    const agent = await Agent.findOneAndUpdate({ agentId: req.params.agentId }, req.body, { new: true });
    if (!agent) {
      return res.status(404).send({ message: 'Agente não encontrado.' });
    }
    res.status(200).send(agent);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Deletar um agente
router.delete('/:agentId', async (req, res) => {
  try {
    const agent = await Agent.findOneAndDelete({ agentId: req.params.agentId });
    if (!agent) {
      return res.status(404).send({ message: 'Agente não encontrado.' });
    }
    res.status(200).send({ message: 'Agente deletado com sucesso.' });
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
