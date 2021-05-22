var express = require('express');
var app = express();
var cors = require('cors');
var bodyParser = require('body-parser');
var js2xmlparser = require("js2xmlparser");

    var departamentos = [
        {
            id: 1,
            nome: "Informática"
        },
        {
            id: 2,
            nome: "Qualidade"
        },
        {
            id: 3,
            nome: "Marketing"
        },
        {
            id: 4,
            nome: "Atendimento ao consumidor"
        }
    ];
    var equipes = [
        {
            id: 1,
            nome: "Manhã"
        },
        {
            id: 2,
            nome: "Tarde"
        },
        {
            id: 3,
            nome: "Noite"
        },
        {
            id: 4,
            nome: "Finais de semana"
        }
    ];
    var eventos = [];
    var funcionarios = [
        {
            id: 1,
            nome: "José",
            apelido: "Zé",
            foto: "https://th.bing.com/th/id/Rc779998ddca214bc31b2ea2d8545a2a2?rik=cY99%2bTxcwv6Z4w&pid=ImgRaw",
            idDepartamento: 2,
            idTime: 1,
            idEquipe: 1
        },
        {
            id: 2,
            nome: "Maria",
            apelido: "Malu",
            foto: "https://image.freepik.com/fotos-gratis/mulher-bonita-de-vestido-preto_1303-10795.jpg",
            idDepartamento: 1,
            idTime: 2,
            idEquipe: 2
        },
        {
            id: 3,
            nome: "Rodrigo",
            apelido: "Tulla Luana",
            foto: "https://th.bing.com/th/id/R7ede3fd5b3e23e1d8975bc51bb9681b4?rik=tgJH32CKcXiEPQ&riu=http%3a%2f%2f1.bp.blogspot.com%2f_xOec0zsYJ_M%2fTKIrkSMGleI%2fAAAAAAAAAB0%2fx_zQDVkOFrw%2fs1600%2fjoe-jonas-2010.jpg&ehk=Hqe2ZQq6CAYqqEfMpd24yoFzRf8dE3X29zStUBlAa1k%3d&risl=&pid=ImgRaw",
            idDepartamento: 1,
            idTime: 2,
            idEquipe: 4
        },
        {
            id: 4,
            nome: "Pablo",
            apelido: "Pablito",
            foto: "https://th.bing.com/th/id/OIP.VHI7QC2HTrmDJy553wbxKwHaKr?pid=ImgDet&rs=1",
            idDepartamento: 3,
            idTime: 3,
            idEquipe: 2
        },
        {
            id: 5,
            nome: "Samira",
            apelido: "Sami",
            foto: "https://www.dicasdemulher.com.br/wp-content/uploads/2020/03/cabelo-cacheado-loiro-18.jpg",
            idDepartamento: 4,
            idTime: 4,
            idEquipe: 3
        }
      ];
      var locais = [
        {id: 1, nome: "Sala do Café"},
        {id: 2, nome: "Praça"},
        {id: 3, nome: "Sala de Reuniões"},
        {id: 4, nome: "Sala 07"}
      ];
      var times = [
        {id: 1, nome: "Fix-it"},
        {id: 2, nome: "Programação"},
        {id: 3, nome: "Propaganda no Instagram"},
        {id: 4, nome: "FAQ"}
      ];
      var tipos = [
        {id: 1, nome: "Reunião"},
        {id: 2, nome: "Mini-curso"},
        {id: 3, nome: "Palestra"},
        {id: 4, nome: "Apresentação"},
      ];

    app.use(bodyParser.json());
    app.use(bodyParser.urlencoded({ extended: true }));
    app.use(cors());

    app.get('/departamentos', function (req, res) {
        setTimeout(function(){
        res.header('Access-Control-Allow-Origin', '*')
        .send(200, departamentos);
        }, 4000);
    });
    app.get('/equipes', function (req, res) {
        setTimeout(function(){
        res.header('Access-Control-Allow-Origin', '*')
        .send(200, equipes);
        }, 4000);
    });
    app.get('/eventos', function (req, res) {
        setTimeout(function(){
        res.header('Access-Control-Allow-Origin', '*')
        .send(200, eventos);
        }, 4000);
    });
    app.get('/funcionarios', function (req, res) {
        setTimeout(function(){
        res.header('Access-Control-Allow-Origin', '*')
        .send(200, funcionarios);
        }, 4000);
    });
    app.get('/locais', function (req, res) {
        setTimeout(function(){
        res.header('Access-Control-Allow-Origin', '*')
        .send(200, locais);
        }, 4000);
    });
    app.get('/times', function (req, res) {
        setTimeout(function(){
        res.header('Access-Control-Allow-Origin', '*')
        .send(200, times);
        }, 4000);
    });
    app.get('/tipos', function (req, res) {
        setTimeout(function(){
        res.header('Access-Control-Allow-Origin', '*')
        .send(200, tipos);
        }, 4000);
    });

    app.post('/eventos', (req, res) => {
        var id = req.body.id;
        var idOrg = req.body.idOrg;
        var tipo = req.body.tipo;
        var local = req.body.local;
        var data = req.body.data;
        var hora = req.body.hora;
        var departamentos = req.body.departamentos;
        var equipes = req.body.equipes;
        var times = req.body.times;
        var idFuncs = req.body.idFuncs;

        eventos.push({id: id, idOrg: idOrg, tipo: tipo, local: local, data: data, hora: hora, departamentos: departamentos, equipes: equipes, times: times, idFuncs: idFuncs});
        console.log('EVENTO POSTADO COM SUCESSO!');
    });

    app.put('/eventos/:id', (req, res) => {
	    var id = req.params.id;
        var item = eventos.find(item => item.id == id);
    });

	app.delete('/eventos/:id', (req, res) => {
	    var id = req.params.id;
        var indice = eventos.findIndex(item => item.id == id);
        eventos[indice] = null;
        var novoVetor = [];
        for(var i = 0; i < eventos.length; i++)
        {
            if(eventos[i] != null)
            {
                novoVetor.push(eventos[i]);
            }
        }
        eventos = novoVetor;
    });

    app.listen(3000);
    console.log('A API está no ar');