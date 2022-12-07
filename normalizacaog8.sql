
CREATE TABLE cores (
                hexadecimal VARCHAR(10) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                CONSTRAINT cores_pk PRIMARY KEY (hexadecimal)
);
COMMENT ON TABLE cores IS 'armazena as cores disponíveis no jogo';
COMMENT ON COLUMN cores.hexadecimal IS 'armazena o código hexadecimal da cor';
COMMENT ON COLUMN cores.nome IS 'nome da cor';


CREATE TABLE configuracoes (
                id_config VARCHAR(5) NOT NULL,
                volume VARCHAR(20) NOT NULL,
                brilho VARCHAR(20) NOT NULL,
                CONSTRAINT configuracoes_pk PRIMARY KEY (id_config)
);
COMMENT ON TABLE configuracoes IS 'configurações de jogabilidade dos jogos';
COMMENT ON COLUMN configuracoes.id_config IS 'chave primária da tabela, codigo unico identificador da tabela';
COMMENT ON COLUMN configuracoes.volume IS 'armazena o volume do jogo escolhido';
COMMENT ON COLUMN configuracoes.brilho IS 'brilho escolhido pelo usuário';


CREATE TABLE imagens_fundo (
                endereco_img VARCHAR(50) NOT NULL,
                id_config VARCHAR(5) NOT NULL,
                CONSTRAINT imgfundo_pk PRIMARY KEY (endereco_img)
);
COMMENT ON TABLE imagens_fundo IS 'armazena as imagens que ficarão no fundo das configurações';
COMMENT ON COLUMN imagens_fundo.id_config IS 'chave primária da tabela, codigo unico identificador da tabela';


CREATE TABLE config_cor (
                id_config VARCHAR(5) NOT NULL,
                hexadecimal VARCHAR(10) NOT NULL,
                CONSTRAINT configcor_pk PRIMARY KEY (id_config, hexadecimal)
);
COMMENT ON TABLE config_cor IS 'armazena as cores disponíveis para cada configuração';
COMMENT ON COLUMN config_cor.id_config IS 'chave primária composta da tabela';
COMMENT ON COLUMN config_cor.hexadecimal IS 'chave primária composta da tabela';


CREATE TABLE jogos (
                id_jogo VARCHAR(5) NOT NULL,
                nome VARCHAR(20) NOT NULL,
                objetivo VARCHAR(100) NOT NULL,
                num_niveis INTEGER NOT NULL,
                data_criacao DATE NOT NULL,
                CONSTRAINT jogos_pk PRIMARY KEY (id_jogo)
);
COMMENT ON TABLE jogos IS 'tabela que armazena os jogos';
COMMENT ON COLUMN jogos.id_jogo IS 'chave primária da tabela, armazena o código unico identificador de cada jogo';
COMMENT ON COLUMN jogos.nome IS 'nome do jogo';
COMMENT ON COLUMN jogos.objetivo IS 'objetivo do jogo';
COMMENT ON COLUMN jogos.num_niveis IS 'numero de niveis que compõe o jogo';
COMMENT ON COLUMN jogos.data_criacao IS 'data de criação do jogo';


CREATE TABLE personalizacoes (
                id_config VARCHAR(5) NOT NULL,
                id_jogo VARCHAR(5) NOT NULL,
                data_config DATE NOT NULL,
                hora NUMERIC(4,2) NOT NULL,
                cor VARCHAR(20) NOT NULL,
                brilho VARCHAR(20) NOT NULL,
                som VARCHAR(20) NOT NULL,
                imagem VARCHAR(20) NOT NULL,
                CONSTRAINT personaliza_pk PRIMARY KEY (id_config, id_jogo)
);
COMMENT ON TABLE personalizacoes IS 'armazena as preferências de personalização de cada usuário';
COMMENT ON COLUMN personalizacoes.id_config IS 'chave primária composta da tabela';
COMMENT ON COLUMN personalizacoes.id_jogo IS 'chave primária composta da tabela';
COMMENT ON COLUMN personalizacoes.data_config IS 'data em que a personalização foi feita';
COMMENT ON COLUMN personalizacoes.hora IS 'hora em que a personalização foi configurada';
COMMENT ON COLUMN personalizacoes.cor IS 'cor da personalização';
COMMENT ON COLUMN personalizacoes.brilho IS 'brilho escolhido na personalização';
COMMENT ON COLUMN personalizacoes.som IS 'armazena o som de cada personalização';
COMMENT ON COLUMN personalizacoes.imagem IS 'armazena o endereço da imagem escolhida para personalização';


CREATE TABLE objetos (
                id_objeto VARCHAR(5) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                descrição VARCHAR(100) NOT NULL,
                CONSTRAINT objetos_pk PRIMARY KEY (id_objeto)
);
COMMENT ON TABLE objetos IS 'armazena os objetos utilizados em níveis';
COMMENT ON COLUMN objetos.id_objeto IS 'código único identificador do objeto';
COMMENT ON COLUMN objetos.nome IS 'nome objeto';
COMMENT ON COLUMN objetos.descrição IS 'descreve o objeto';


CREATE TABLE trilha_sonora (
                id_trilha VARCHAR(5) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                valencia VARCHAR(10) NOT NULL,
                CONSTRAINT som_pk PRIMARY KEY (id_trilha)
);
COMMENT ON TABLE trilha_sonora IS 'armazena os dados relativos a trilha sonora do jogo';
COMMENT ON COLUMN trilha_sonora.id_trilha IS 'armazena um código único identificador da trilha sonora';
COMMENT ON COLUMN trilha_sonora.nome IS 'nome da trilha sonora utilizada';
COMMENT ON COLUMN trilha_sonora.valencia IS 'aceita apenas três entradas: positiva, negativa ou neutra';


CREATE TABLE missoes (
                id_missao VARCHAR(5) NOT NULL,
                nome VARCHAR(20) NOT NULL,
                tempo_maximo NUMERIC(6,2),
                pontuação INTEGER NOT NULL,
                CONSTRAINT missoes_pk PRIMARY KEY (id_missao)
);
COMMENT ON TABLE missoes IS 'armazenas as missões jogadas';
COMMENT ON COLUMN missoes.id_missao IS 'chave primária da tabela, código único identificador de cada missão';
COMMENT ON COLUMN missoes.nome IS 'nome escolhido para a missão';
COMMENT ON COLUMN missoes.tempo_maximo IS 'tempo maximo para realização da missão';
COMMENT ON COLUMN missoes.pontuação IS 'pontuação maxima a ser auferida nessa missão';


CREATE TABLE composicoes (
                id_missao VARCHAR(5) NOT NULL,
                id_objeto VARCHAR(5) NOT NULL,
                posicao_inicial VARCHAR(50) NOT NULL,
                pontos INTEGER NOT NULL,
                CONSTRAINT comp_pk PRIMARY KEY (id_missao, id_objeto)
);
COMMENT ON TABLE composicoes IS 'armazena as combinações de objetos e jogos';
COMMENT ON COLUMN composicoes.id_missao IS 'chave primária composta da tabela';
COMMENT ON COLUMN composicoes.id_objeto IS 'chave primária composta da tabela';
COMMENT ON COLUMN composicoes.posicao_inicial IS 'posição inicial dos objetos na missão';
COMMENT ON COLUMN composicoes.pontos IS 'pontos destinados às composições';


CREATE TABLE objetivo_secundario (
                id_obsecundario VARCHAR(5) NOT NULL,
                objetivo_secundario VARCHAR(100) NOT NULL,
                dificuldade VARCHAR(20) NOT NULL,
                id_missao VARCHAR(5) NOT NULL,
                CONSTRAINT secundario_pk PRIMARY KEY (id_obsecundario)
);
COMMENT ON TABLE objetivo_secundario IS 'armazena todos os objetivos secundários do jogo';
COMMENT ON COLUMN objetivo_secundario.id_obsecundario IS 'chave primária da tabela, armazenada em forma de codigo unico identificador.';
COMMENT ON COLUMN objetivo_secundario.objetivo_secundario IS 'especifica o objetivo secundário da missão';
COMMENT ON COLUMN objetivo_secundario.dificuldade IS 'armazena a dificuldade de conclusão do objetivo secundário';
COMMENT ON COLUMN objetivo_secundario.id_missao IS 'chave estrangeira da tabela missões, uma missão poderá ter 0, um ou n objetivos secundários';


CREATE TABLE objetivo_principal (
                id_objetivo VARCHAR(5) NOT NULL,
                objetivo_principal VARCHAR(100) NOT NULL,
                dificuldade VARCHAR(20) NOT NULL,
                id_missao VARCHAR(5) NOT NULL,
                CONSTRAINT objprinc_pk PRIMARY KEY (id_objetivo)
);
COMMENT ON TABLE objetivo_principal IS 'armazena objetivos principais dos níveis';
COMMENT ON COLUMN objetivo_principal.id_objetivo IS 'chave primária da tabela, código único identificador';
COMMENT ON COLUMN objetivo_principal.objetivo_principal IS 'nomeia o objetivo principal da missão, uma missão pode ter 1 ou mais objetivos principais';
COMMENT ON COLUMN objetivo_principal.dificuldade IS 'armazena nível de conclusão do objetivo';
COMMENT ON COLUMN objetivo_principal.id_missao IS 'chave estrangeira da tabela missões, 1 missão pode ter 0, 1 ou n objetivos principais';


CREATE TABLE nivel (
                id_nivel VARCHAR(5) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_missao VARCHAR(5) NOT NULL,
                id_jogo VARCHAR(5) NOT NULL,
                CONSTRAINT nivel_pk PRIMARY KEY (id_nivel)
);
COMMENT ON TABLE nivel IS 'armazena as informações relativas aos níveis do jogo';
COMMENT ON COLUMN nivel.id_nivel IS 'chave primária da tabela, armazena a codificação de cada nível do jogo';
COMMENT ON COLUMN nivel.nome IS 'armazena o nome de cada nível';
COMMENT ON COLUMN nivel.id_missao IS 'chave estrangeira da tabela missões, 1 nível tem 1 misão e 1 missão pode ser utilizada em 0 ou 1 nível';
COMMENT ON COLUMN nivel.id_jogo IS 'chave estrangeira da tabela jogos, um nivel pode ser utilizado em 1 jogo, enquanto um jogo pode ter 1 ou n níveis';


CREATE TABLE trilha_nivel (
                id_nivel VARCHAR(5) NOT NULL,
                id_trilha VARCHAR(5) NOT NULL,
                CONSTRAINT tn_pk PRIMARY KEY (id_nivel, id_trilha)
);
COMMENT ON TABLE trilha_nivel IS 'armazena a(s) trilhas sonoras relativas a cada nível';
COMMENT ON COLUMN trilha_nivel.id_nivel IS 'chave primária particionada, nivel em que será usada determinada trilha';
COMMENT ON COLUMN trilha_nivel.id_trilha IS 'chave primária composta, trilha que será usada em cada nível';


CREATE TABLE personagens (
                id_personagem VARCHAR(5) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                imagem VARCHAR(50) NOT NULL,
                CONSTRAINT personagens_pk PRIMARY KEY (id_personagem)
);
COMMENT ON TABLE personagens IS 'armazena as informações relativas a cada personagem criado';
COMMENT ON COLUMN personagens.id_personagem IS 'código único identificador de cada personagem criado, chave primária da tabela';
COMMENT ON COLUMN personagens.nome IS 'nome escolhido para cada personagem criado';
COMMENT ON COLUMN personagens.imagem IS 'campo que armazena o endereçamento de cada imagem';


CREATE TABLE pers_nivel (
                id_personagem VARCHAR(5) NOT NULL,
                id_nivel VARCHAR(5) NOT NULL,
                CONSTRAINT persnivel_pk PRIMARY KEY (id_personagem, id_nivel)
);
COMMENT ON TABLE pers_nivel IS 'armazena os personagens que participam de determinado nível do jog';
COMMENT ON COLUMN pers_nivel.id_personagem IS 'código único identificador de cada personagem criado, chave primária da tabela';
COMMENT ON COLUMN pers_nivel.id_nivel IS 'chave primária da tabela, armazena a codificação de cada nível do jogo';


CREATE TABLE cenarios (
                id_cenarios VARCHAR(5) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                tema VARCHAR(50) NOT NULL,
                CONSTRAINT cenarios_pk PRIMARY KEY (id_cenarios)
);
COMMENT ON TABLE cenarios IS 'armazena as informações relativas ao cenário do jogo.';
COMMENT ON COLUMN cenarios.id_cenarios IS 'chave primária da tabela cenarios, codificação única para identificação';
COMMENT ON COLUMN cenarios.nome IS 'nome do cenário';
COMMENT ON COLUMN cenarios.tema IS 'tema escolhido para o cenário, palheta de cores, etc.';


CREATE TABLE cenarios_niveis (
                id_cenarios VARCHAR(5) NOT NULL,
                id_nivel VARCHAR(5) NOT NULL,
                CONSTRAINT cn_pk PRIMARY KEY (id_cenarios, id_nivel)
);
COMMENT ON TABLE cenarios_niveis IS 'armazena os cenários que são utilizados em cada nível';
COMMENT ON COLUMN cenarios_niveis.id_cenarios IS 'chave primária composta da tabela cenarios_niveis';
COMMENT ON COLUMN cenarios_niveis.id_nivel IS 'chave primária composta da tabela cenarios niveis';


CREATE TABLE continente (
                id_continente VARCHAR(5) NOT NULL,
                nome_regiao VARCHAR(50) NOT NULL,
                CONSTRAINT continente_pk PRIMARY KEY (id_continente)
);
COMMENT ON TABLE continente IS 'armazena os continentes dos jogadores';
COMMENT ON COLUMN continente.id_continente IS 'chave primária da tabela continente, código identificador único';
COMMENT ON COLUMN continente.nome_regiao IS 'armazena os nomes de cada região';


CREATE TABLE pais (
                id_pais VARCHAR(5) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                sigla VARCHAR(3) NOT NULL,
                id_continente VARCHAR(5) NOT NULL,
                CONSTRAINT pais_pk PRIMARY KEY (id_pais)
);
COMMENT ON TABLE pais IS 'armazena os países dos jogadores';
COMMENT ON COLUMN pais.id_pais IS 'chave primária da tabela país, código único identificador';
COMMENT ON COLUMN pais.nome IS 'armazena nome do país';
COMMENT ON COLUMN pais.sigla IS 'armazena sigla do país';
COMMENT ON COLUMN pais.id_continente IS 'chave estrangeira da tabela continente.';


CREATE TABLE jogadores (
                id_jogador VARCHAR(50) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                apelido VARCHAR(50) NOT NULL,
                imagem VARCHAR(50) NOT NULL,
                data_registro DATE NOT NULL,
                localizacao VARCHAR(5),
                CONSTRAINT jogadores_pk PRIMARY KEY (id_jogador)
);
COMMENT ON TABLE jogadores IS 'armazena as informaçoes relativas aos usuários do jogo.';
COMMENT ON COLUMN jogadores.id_jogador IS 'chave primária da tabela jogadores, id único que diferencia os jogadores entre si';
COMMENT ON COLUMN jogadores.nome IS 'armazena o nome verdadeiro de cada usuário';
COMMENT ON COLUMN jogadores.apelido IS 'armazena o nome fictício que será exibido em partidas online para os outros jogadores';
COMMENT ON COLUMN jogadores.imagem IS 'armazena o endereço da imagem de exibição do usuário';
COMMENT ON COLUMN jogadores.data_registro IS 'armazena a data de cadastro do usuário no jogo';
COMMENT ON COLUMN jogadores.localizacao IS 'chave estrangeira da tabela país';


CREATE TABLE partidas (
                id_partida VARCHAR(5) NOT NULL,
                id_jogador VARCHAR(50) NOT NULL,
                id_nivel VARCHAR(5) NOT NULL,
                data_inicio DATE NOT NULL,
                hora_inicio TIME NOT NULL,
                data_final DATE NOT NULL,
                hora_final TIME NOT NULL,
                pontuacao INTEGER NOT NULL,
                CONSTRAINT partidas_pk PRIMARY KEY (id_partida, id_jogador, id_nivel)
);
COMMENT ON TABLE partidas IS 'armazena as partidas jogadas pelos jogadores';
COMMENT ON COLUMN partidas.id_partida IS 'armazena um código único identificador para cada partida, necessário pois cada jogador pode jogar o mesmo nível mais de uma vez';
COMMENT ON COLUMN partidas.id_jogador IS 'chave primária composta da tabela';
COMMENT ON COLUMN partidas.id_nivel IS 'chave primária composta da tabela';
COMMENT ON COLUMN partidas.data_inicio IS 'data em que o usuário iniciou a partida';
COMMENT ON COLUMN partidas.hora_inicio IS 'registra a hora que o jogador iniciou a partida';
COMMENT ON COLUMN partidas.data_final IS 'data em que o usuário completou o nível, ou desistiu';
COMMENT ON COLUMN partidas.hora_final IS 'armazena a hora em que o usuário finalizou a partida ou desligou-se do jogo';
COMMENT ON COLUMN partidas.pontuacao IS 'armazena a pontuação do usuário na partida';


ALTER TABLE config_cor ADD CONSTRAINT cor_config_cor_fk
FOREIGN KEY (hexadecimal)
REFERENCES cores (hexadecimal)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE personalizacoes ADD CONSTRAINT configuracoes_personalizacoes_fk
FOREIGN KEY (id_config)
REFERENCES configuracoes (id_config)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE config_cor ADD CONSTRAINT configuracoes_config_cor_fk
FOREIGN KEY (id_config)
REFERENCES configuracoes (id_config)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE imagens_fundo ADD CONSTRAINT configuracoes_imagens_fundo_fk
FOREIGN KEY (id_config)
REFERENCES configuracoes (id_config)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE nivel ADD CONSTRAINT jogos_nivel_fk
FOREIGN KEY (id_jogo)
REFERENCES jogos (id_jogo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE personalizacoes ADD CONSTRAINT jogos_personalizacoes_fk
FOREIGN KEY (id_jogo)
REFERENCES jogos (id_jogo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE composicoes ADD CONSTRAINT objetos_composicoes_fk
FOREIGN KEY (id_objeto)
REFERENCES objetos (id_objeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trilha_nivel ADD CONSTRAINT trilha_sonora_trilha_nivel_fk
FOREIGN KEY (id_trilha)
REFERENCES trilha_sonora (id_trilha)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE objetivo_principal ADD CONSTRAINT missoes_objetivo_principal_fk
FOREIGN KEY (id_missao)
REFERENCES missoes (id_missao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE objetivo_secundario ADD CONSTRAINT missoes_objetivo_secundarios_fk
FOREIGN KEY (id_missao)
REFERENCES missoes (id_missao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE nivel ADD CONSTRAINT missoes_nivel_fk
FOREIGN KEY (id_missao)
REFERENCES missoes (id_missao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE composicoes ADD CONSTRAINT missoes_composicoes_fk
FOREIGN KEY (id_missao)
REFERENCES missoes (id_missao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE partidas ADD CONSTRAINT nivel_partidas_fk
FOREIGN KEY (id_nivel)
REFERENCES nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cenarios_niveis ADD CONSTRAINT nivel_cenarios_niveis_fk
FOREIGN KEY (id_nivel)
REFERENCES nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trilha_nivel ADD CONSTRAINT nivel_trilha_nivel_fk
FOREIGN KEY (id_nivel)
REFERENCES nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pers_nivel ADD CONSTRAINT nivel_pers_nivel_fk
FOREIGN KEY (id_nivel)
REFERENCES nivel (id_nivel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pers_nivel ADD CONSTRAINT personagens_pers_nivel_fk
FOREIGN KEY (id_personagem)
REFERENCES personagens (id_personagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cenarios_niveis ADD CONSTRAINT cenarios_cenarios_niveis_fk
FOREIGN KEY (id_cenarios)
REFERENCES cenarios (id_cenarios)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pais ADD CONSTRAINT continente_pais_fk
FOREIGN KEY (id_continente)
REFERENCES continente (id_continente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE jogadores ADD CONSTRAINT pais_jogadores_fk
FOREIGN KEY (localizacao)
REFERENCES pais (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE partidas ADD CONSTRAINT jogadores_partidas_fk
FOREIGN KEY (id_jogador)
REFERENCES jogadores (id_jogador)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
