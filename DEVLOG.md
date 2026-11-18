## Aula 08 -- 07/10 (feita em 14 e 15/11)

O que fiz: o porão com chão de madeira, paredes e móveis, e o Ceifador andando com a câmera.
O que travou: o "Open Git Bash here" não aparecia no Windows; e o primeiro mapa ficou gigante (7700 x 5050 px).
Como resolvi: abri o terminal digitando cmd na barra de endereço; refiz o mapa com aproximadamente 640 x 384.
Adaptação: a personagem só tem desenho de lado, então usei uma animação andando + flip_h em vez de 4 direções.

## Aula 11 -- 04/11 (feita em 15/11)

O que fiz: coloquei a arte do meu tema no lugar do boneco vermelho: o cenário Cozy Interior (shubibubi), o Ceifador (SamuelLee) e a aranha de poeira (SR Studios Kerala). A aranha era grande (582 px por quadro), então reduzi para 0.04; a rainha usa 0.08. Também fiz a "rota mais barata": a aranha recalcula o caminho 5 vezes por segundo, com um Timer de 0.2 s, em vez de 60 vezes.

O que travou: medi o FPS com a horda cheia e ele ficou em 60 antes e depois, porque o Godot limita ao monitor, então não dava para ver diferença por ele. Não anotei os outros valores antes da mudança (apenas o FPS).

Como resolvi: olhei o Physics Process no Debugger → Monitors: 0.20 ms com a horda cheia, depois de mais de 1 minuto de jogo. O jogo não travou em nenhum momento.

## Aula 12 -- 11/11 (feita em 18/11)

O que fiz: coloquei imagens de fundo nas telas de vitória e derrota, exportei o jogo para Windows (um .exe só, com Embed PCK) e publiquei a página do jogo no itch.io.
O que travou: o download dos modelos de exportação pelo Godot falhou várias vezes; o git push foi recusado por um conflito no README.md; e o itch.io não deixava enviar o arquivo antes de confirmar o e-mail, nem marcar a página como Public antes de salvar.
Como resolvi: baixei o arquivo .tpz pelo GitHub da Godot e instalei pelo "Install from File"; no Git, fiz o pull, escolhi o texto certo no README e apaguei as marcações do conflito; no itch.io, confirmei o e-mail, salvei a página como Draft e depois mudei para Public.
