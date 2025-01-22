const express = require('express');
const router = express.Router();
const Task = require('../models/Task');

// Criar uma nova tarefa
router.post('/', async (req, res) => {
  try {
    const task = new Task(req.body);
    await task.save();
    res.status(201).send(task);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Obter todas as tarefas
router.get('/', async (req, res) => {
  try {
    const tasks = await Task.find();
    res.status(200).send(tasks);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Obter uma tarefa pelo ID
router.get('/:taskId', async (req, res) => {
  try {
    const task = await Task.findOne({ taskId: req.params.taskId });
    if (!task) {
      return res.status(404).send({ message: 'Tarefa não encontrada.' });
    }
    res.status(200).send(task);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Atualizar uma tarefa
router.put('/:taskId', async (req, res) => {
  try {
    const task = await Task.findOneAndUpdate({ taskId: req.params.taskId }, req.body, { new: true });
    if (!task) {
      return res.status(404).send({ message: 'Tarefa não encontrada.' });
    }
    res.status(200).send(task);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Deletar uma tarefa
router.delete('/:taskId', async (req, res) => {
  try {
    const task = await Task.findOneAndDelete({ taskId: req.params.taskId });
    if (!task) {
      return res.status(404).send({ message: 'Tarefa não encontrada.' });
    }
    res.status(200).send({ message: 'Tarefa deletada com sucesso.' });
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
