import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../database/chamado_dao.dart';
import '../../model/chamado.dart';

class EnviarChamado extends StatefulWidget {

  const EnviarChamado({super.key});

  @override
  _EnviarChamadoState createState() => _EnviarChamadoState();
}

class _EnviarChamadoState extends State<EnviarChamado> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedGravidade;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _gravidadeController = TextEditingController();
  XFile? _recurso;

  Future<void> _openCameraForImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _recurso = image;
    });
  }

  Future<void> _openCameraForVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    setState(() {
      _recurso = video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Central de Atendimento de TI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _tituloController,
                  decoration: const InputDecoration(
                    labelText: "Qual o problema?",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _descricaoController,
                  decoration: const InputDecoration(
                    labelText: "Descreva o seu problema detalhadamente",
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Gravidade do problema:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                RadioListTile<String>(
                  title: const Text('Leve'),
                  value: 'LEVE',
                  groupValue: _selectedGravidade,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGravidade = value;
                      _gravidadeController.text = value ?? '';
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Média'),
                  value: 'MEDIA',
                  groupValue: _selectedGravidade,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGravidade = value;
                      _gravidadeController.text = value ?? '';
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Urgente'),
                  value: 'URGENTE',
                  groupValue: _selectedGravidade,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGravidade = value;
                      _gravidadeController.text = value ?? '';
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enviar foto ou vídeo:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: _openCameraForImage,
                      icon: const Icon(Icons.photo_camera),
                      label: const Text('Tirar Foto'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: _openCameraForVideo,
                      icon: const Icon(Icons.videocam),
                      label: const Text('Gravar Vídeo'),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Espaço maior antes do botão Enviar Chamado
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final String titulo = _tituloController.text.trim();
                        final String descricao = _descricaoController.text
                            .trim();
                        final String gravidade = _gravidadeController.text
                            .trim(); // Usar _gravidadeController.text ao invés de _gravidadeController

                        Chamado chamado = Chamado(
                          titulo: titulo,
                          descricao: descricao,
                          gravidade: gravidade,
                        );

                        ChamadoDAO.cadastrarChamado(chamado);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Chamado enviado com sucesso!'),
                          ),
                        );

                        _tituloController.clear();
                        _descricaoController.clear();
                        _gravidadeController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Por favor, preencha todos os campos obrigatórios.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple, // Botão roxo
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      textStyle: const TextStyle(fontSize: 25),
                    ),
                    child: const Text(
                      'SOLICITAR CHAMADO',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
