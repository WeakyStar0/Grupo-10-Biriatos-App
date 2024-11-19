import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Política de Privacidade e Termos de Utilização')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Política de Privacidade e Termos de Utilização\n\n',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Identificação do Responsável pelo Tratamento\n\n'
                'O tratamento dos dados pessoais fornecidos na plataforma "Viriatos Scouting" '
                'é da responsabilidade do Sport Club Académico de Viseu.\n\n'
                'Entidade Responsável: Sport Club Académico de Viseu\n'
                'NIPC: 503954306\n'
                'Sede: Estádio Municipal do Fontelo, Avenida Anacleto Pinto, Viseu, Portugal\n\n'
                'Informação, Consentimento e Finalidade do Tratamento\n\n'
                'A plataforma "Viriatos Scouting" recolhe e trata dados pessoais de acordo com a Lei da '
                'Proteção de Dados Pessoais (Lei 58/2019) e o Regulamento Geral de Proteção de Dados (RGPD - '
                'Regulamento UE 2016/679). Ao aceitar esta Política de Privacidade e Termos de Utilização, o '
                'utilizador consente de forma informada, livre e inequívoca que os dados pessoais sejam tratados '
                'pelo Académico de Viseu para:\n\n'
                'Registo e gestão dos dados do atleta;\n'
                'Criação de relatórios de desempenho e histórico desportivo do atleta para avaliação e desenvolvimento '
                'de talentos no clube.\n\n'
                'Os dados recolhidos não incluem informações sensíveis como convicções políticas, filiação sindical, '
                'religião, saúde, ou vida sexual. Estes dados serão exclusivamente utilizados para os fins acima descritos '
                'e não serão cedidos a terceiros sem consentimento prévio do titular dos dados.\n\n'
                'Medidas de Segurança\n\n'
                'O Académico de Viseu adota medidas técnicas e organizativas para assegurar a proteção dos dados pessoais '
                'armazenados na plataforma "Viriatos Scouting", prevenindo acessos não autorizados, perdas ou alterações. '
                'Este compromisso de segurança é continuamente atualizado de acordo com a tecnologia disponível e com a '
                'natureza dos dados armazenados.\n\n'
                'Direitos do Titular dos Dados\n\n'
                'Os utilizadores e/ou encarregados de educação dos atletas poderão, a qualquer momento, exercer os seus direitos '
                'de:\n\n'
                'Acesso, retificação, apagamento, limitação do tratamento, portabilidade dos dados e oposição ao tratamento '
                'dos dados pessoais.\n\n'
                'Para o exercício destes direitos, os utilizadores devem contactar o Encarregado da Proteção de Dados através '
                'do endereço de e-mail indicado.\n\n'
                'Prazo de Conservação dos Dados\n\n'
                'Os dados pessoais dos atletas serão mantidos durante o período necessário para o cumprimento dos objetivos da '
                'plataforma, nomeadamente para o acompanhamento do histórico e desenvolvimento desportivo. Após este período, '
                'e exceto em situações de exigência legal, os dados serão eliminados ou anonimizados.\n\n'
                'Autoridade de Controlo\n\n'
                'Em caso de necessidade, os utilizadores poderão apresentar uma reclamação junto da autoridade competente em '
                'matéria de proteção de dados pessoais, a Comissão Nacional de Proteção de Dados (CNPD).\n\n'
                'Alterações à Política de Privacidade\n\n'
                'O Académico de Viseu reserva-se o direito de atualizar esta Política de Privacidade e Termos de Utilização conforme '
                'necessário, sendo qualquer alteração comunicada aos utilizadores através da plataforma "Viriatos Scouting".\n\n',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
