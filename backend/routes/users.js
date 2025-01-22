const express = require('express');
const router = express.Router();
const User = require('../models/User');

// Criar um novo usuário
router.post('/', async (req, res) => {
  try {
    const user = new User(req.body);
    await user.save();
    res.status(201).send(user);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Obter todos os usuários
router.get('/', async (req, res) => {
  try {
    const users = await User.find();
    res.status(200).send(users);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Obter um usuário pelo ID
router.get('/:userId', async (req, res) => {
  try {
    const user = await User.findOne({ userId: req.params.userId });
    if (!user) {
      return res.status(404).send({ message: 'Usuário não encontrado.' });
    }
    res.status(200).send(user);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Atualizar um usuário
router.put('/:userId', async (req, res) => {
  try {
    const user = await User.findOneAndUpdate({ userId: req.params.userId }, req.body, { new: true });
    if (!user) {
      return res.status(404).send({ message: 'Usuário não encontrado.' });
    }
    res.status(200).send(user);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Deletar um usuário
router.delete('/:userId', async (req, res) => {
  try {
    const user = await User.findOneAndDelete({ userId: req.params.userId });
    if (!user) {
      return res.status(404).send({ message: 'Usuário não encontrado.' });
    }
    res.status(200).send({ message: 'Usuário deletado com sucesso.' });
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
