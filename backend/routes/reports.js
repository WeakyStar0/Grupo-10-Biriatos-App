const express = require('express');
const router = express.Router();
const Report = require('../models/Report');

// Criar um novo relatório
router.post('/', async (req, res) => {
  try {
    const report = new Report(req.body);
    await report.save();
    res.status(201).send(report);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Obter todos os relatórios
router.get('/', async (req, res) => {
  try {
    const reports = await Report.find();
    res.status(200).send(reports);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Obter um relatório pelo ID
router.get('/:reportId', async (req, res) => {
  try {
    const report = await Report.findOne({ reportId: req.params.reportId });
    if (!report) {
      return res.status(404).send({ message: 'Relatório não encontrado.' });
    }
    res.status(200).send(report);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Atualizar um relatório
router.put('/:reportId', async (req, res) => {
  try {
    const report = await Report.findOneAndUpdate({ reportId: req.params.reportId }, req.body, { new: true });
    if (!report) {
      return res.status(404).send({ message: 'Relatório não encontrado.' });
    }
    res.status(200).send(report);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Deletar um relatório
router.delete('/:reportId', async (req, res) => {
  try {
    const report = await Report.findOneAndDelete({ reportId: req.params.reportId });
    if (!report) {
      return res.status(404).send({ message: 'Relatório não encontrado.' });
    }
    res.status(200).send({ message: 'Relatório deletado com sucesso.' });
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
