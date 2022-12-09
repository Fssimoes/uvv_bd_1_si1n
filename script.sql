
CREATE TABLE public.clientes (
                codigo_cliente INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                data_nascimento DATE NOT NULL,
                sexo CHAR NOT NULL,
                estado_civil VARCHAR(20) NOT NULL,
                CONSTRAINT clientes_pk PRIMARY KEY (codigo_cliente)
);


CREATE TABLE public.emprestimos (
                codigo_emprestimo INTEGER NOT NULL,
                data_aquisicao DATE NOT NULL,
                valor NUMERIC(9,2) NOT NULL,
                codigo_cliente INTEGER NOT NULL,
                CONSTRAINT emprestimos_pk PRIMARY KEY (codigo_emprestimo)
);


CREATE TABLE public.parcelas (
                codigo_emprestimo INTEGER NOT NULL,
                numero_parcelo INTEGER NOT NULL,
                valor NUMERIC(9,2) NOT NULL,
                valor_juros NUMERIC(9,2),
                data_vencimento DATE NOT NULL,
                data_pagamento DATE,
                codigo_emprestimo_1 INTEGER NOT NULL,
                valor_multa NUMERIC(9,2),
                CONSTRAINT parcelas_pk PRIMARY KEY (codigo_emprestimo, numero_parcelo)
);


CREATE TABLE public.contas (
                numero_conta INTEGER NOT NULL,
                senha BYTEA NOT NULL,
                data_abertura DATE NOT NULL,
                saldo NUMERIC(9,2) NOT NULL,
                limite_credito NUMERIC(9,2) NOT NULL,
                codigo_cliente INTEGER NOT NULL,
                CONSTRAINT contas_pk PRIMARY KEY (numero_conta)
);


CREATE TABLE public.endereco_cliente (
                codigo_cliente INTEGER NOT NULL,
                logradouro VARCHAR(30) NOT NULL,
                numero INTEGER NOT NULL,
                complemento VARCHAR(20),
                bairro VARCHAR(30) NOT NULL,
                cidade VARCHAR(50) NOT NULL,
                uf CHAR(25) NOT NULL,
                cep CHAR(12) NOT NULL,
                CONSTRAINT endereco_cliente_pk PRIMARY KEY (codigo_cliente)
);


CREATE TABLE public.servicos (
                codigo_servico INTEGER NOT NULL,
                nome VARCHAR(20) NOT NULL,
                descricao VARCHAR(50) NOT NULL,
                CONSTRAINT servicos_pk PRIMARY KEY (codigo_servico)
);


CREATE TABLE public.servico_cliente (
                codigo_cliente INTEGER NOT NULL,
                codigo_servico INTEGER NOT NULL,
                numero_servico_cliente INTEGER NOT NULL,
                CONSTRAINT servico_cliente_pk PRIMARY KEY (codigo_cliente, codigo_servico, numero_servico_cliente)
);


CREATE TABLE public.contratos (
                numero_contrato INTEGER NOT NULL,
                data_assinatura DATE NOT NULL,
                desc_responsabilidades_contratante VARCHAR(200) NOT NULL,
                desc_responsabilidades_contratada VARCHAR(200) NOT NULL,
                codigo_servico INTEGER NOT NULL,
                CONSTRAINT contratos_pk PRIMARY KEY (numero_contrato)
);


CREATE TABLE public.historico (
                codigo_servico INTEGER NOT NULL,
                numero_conta INTEGER NOT NULL,
                numero_historico INTEGER NOT NULL,
                CONSTRAINT historico_pk PRIMARY KEY (codigo_servico, numero_conta, numero_historico)
);


CREATE TABLE public.empregados (
                matricula INTEGER NOT NULL,
                nome VARCHAR(30) NOT NULL,
                cargo VARCHAR(30) NOT NULL,
                salario NUMERIC(9,2) NOT NULL,
                numero_gerente INTEGER,
                CONSTRAINT empregados_pk PRIMARY KEY (matricula)
);


CREATE TABLE public.endereco_empregado (
                matricula INTEGER NOT NULL,
                logradouro VARCHAR(30) NOT NULL,
                numero INTEGER NOT NULL,
                complemento VARCHAR(25),
                bairro VARCHAR(25) NOT NULL,
                cidade VARCHAR(50) NOT NULL,
                uf CHAR(25) NOT NULL,
                cep CHAR(12) NOT NULL,
                CONSTRAINT endereco_empregado_pk PRIMARY KEY (matricula)
);


CREATE TABLE public.bancos (
                numero_banco INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                razao_social VARCHAR(30) NOT NULL,
                site VARCHAR(50) NOT NULL,
                CONSTRAINT bancos_pk PRIMARY KEY (numero_banco, cnpj)
);


CREATE TABLE public.telefone_banco (
                numero_telefone VARCHAR(30) NOT NULL,
                numero_banco INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                CONSTRAINT telefone_banco_pk PRIMARY KEY (numero_telefone, numero_banco, cnpj)
);
COMMENT ON TABLE public.telefone_banco IS 'Atributo multivalorado';


CREATE TABLE public.agencias (
                numero_agencia INTEGER NOT NULL,
                numero_banco INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                CONSTRAINT agencias_pk PRIMARY KEY (numero_agencia, numero_banco, cnpj)
);


CREATE TABLE public.servico_agencia (
                numero_agencia INTEGER NOT NULL,
                numero_banco INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                codigo_servico INTEGER NOT NULL,
                CONSTRAINT servico_agencia_pk PRIMARY KEY (numero_agencia, numero_banco, cnpj, codigo_servico)
);


CREATE TABLE public.lotacao (
                matricula INTEGER NOT NULL,
                numero_agencia INTEGER NOT NULL,
                numero_banco INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                funcao_desempenhada VARCHAR(30) NOT NULL,
                CONSTRAINT lotacao_pk PRIMARY KEY (matricula, numero_agencia, numero_banco, cnpj)
);


CREATE TABLE public.lotacao_dia_horas_trabalhado (
                matricula INTEGER NOT NULL,
                numero_agencia INTEGER NOT NULL,
                numero_banco INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                dias_trabalhado INTEGER NOT NULL,
                horario_de_trabalho INTEGER NOT NULL,
                CONSTRAINT lotacao_dia_horas_trabalhado_pk PRIMARY KEY (matricula, numero_agencia, numero_banco, cnpj)
);


CREATE TABLE public.telefone_agencia (
                numero_agencia INTEGER NOT NULL,
                numero_banco INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                numero_telefone VARCHAR(30) NOT NULL,
                CONSTRAINT telefone_agencia_pk PRIMARY KEY (numero_agencia, numero_banco, cnpj, numero_telefone)
);
COMMENT ON TABLE public.telefone_agencia IS 'Atributo multivalorado';


CREATE TABLE public.endereco_agencia (
                numero_agencia INTEGER NOT NULL,
                numero_banco INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                logradouro VARCHAR(30) NOT NULL,
                numero INTEGER NOT NULL,
                complemento VARCHAR(25),
                bairro VARCHAR(25) NOT NULL,
                cidade VARCHAR(50) NOT NULL,
                uf CHAR(25) NOT NULL,
                cep CHAR(12) NOT NULL,
                CONSTRAINT endereco_agencia_pk PRIMARY KEY (numero_agencia, numero_banco, cnpj)
);


CREATE TABLE public.endereco_banco (
                numero_banco INTEGER NOT NULL,
                cnpj CHAR(14) NOT NULL,
                logradouro VARCHAR(30) NOT NULL,
                numero INTEGER NOT NULL,
                complemento VARCHAR(25),
                bairro VARCHAR(25) NOT NULL,
                cidade VARCHAR(50) NOT NULL,
                uf CHAR(25) NOT NULL,
                cep CHAR(12) NOT NULL,
                CONSTRAINT endereco_banco_pk PRIMARY KEY (numero_banco, cnpj)
);

ALTER TABLE public.clientes
ADD CONSTRAINT CHECK(sexo in('M','F'));


ALTER TABLE public.endereco_cliente ADD CONSTRAINT clientes_endereco_cliente_fk
FOREIGN KEY (codigo_cliente)
REFERENCES public.clientes (codigo_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.contas ADD CONSTRAINT clientes_contas_fk
FOREIGN KEY (codigo_cliente)
REFERENCES public.clientes (codigo_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.servico_cliente ADD CONSTRAINT clientes_servico_cliente_fk
FOREIGN KEY (codigo_cliente)
REFERENCES public.clientes (codigo_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.emprestimos ADD CONSTRAINT clientes_emprestimos_fk
FOREIGN KEY (codigo_cliente)
REFERENCES public.clientes (codigo_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.parcelas ADD CONSTRAINT emprestimos_parcelas_fk
FOREIGN KEY (codigo_emprestimo_1)
REFERENCES public.emprestimos (codigo_emprestimo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico ADD CONSTRAINT contas_historico_fk
FOREIGN KEY (numero_conta)
REFERENCES public.contas (numero_conta)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico ADD CONSTRAINT servicos_historico_fk
FOREIGN KEY (codigo_servico)
REFERENCES public.servicos (codigo_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.servico_agencia ADD CONSTRAINT servicos_servico_agencia_fk
FOREIGN KEY (codigo_servico)
REFERENCES public.servicos (codigo_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.contratos ADD CONSTRAINT servicos_contratos_fk
FOREIGN KEY (codigo_servico)
REFERENCES public.servicos (codigo_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.servico_cliente ADD CONSTRAINT servicos_servico_cliente_fk
FOREIGN KEY (codigo_servico)
REFERENCES public.servicos (codigo_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.endereco_empregado ADD CONSTRAINT empregados_endereco_empregado_fk
FOREIGN KEY (matricula)
REFERENCES public.empregados (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.lotacao ADD CONSTRAINT empregados_lotacao_fk
FOREIGN KEY (matricula)
REFERENCES public.empregados (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (numero_gerente)
REFERENCES public.empregados (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.endereco_banco ADD CONSTRAINT bancos_endereco_banco_fk
FOREIGN KEY (numero_banco, cnpj)
REFERENCES public.bancos (numero_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.agencias ADD CONSTRAINT bancos_agencias_fk
FOREIGN KEY (numero_banco, cnpj)
REFERENCES public.bancos (numero_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.telefone_banco ADD CONSTRAINT bancos_telefone_fk
FOREIGN KEY (numero_banco, cnpj)
REFERENCES public.bancos (numero_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.endereco_agencia ADD CONSTRAINT agencias_endereco_agencia_fk
FOREIGN KEY (numero_agencia, cnpj, numero_banco)
REFERENCES public.agencias (numero_agencia, cnpj, numero_banco)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.telefone_agencia ADD CONSTRAINT agencias_telefone_agencia_fk
FOREIGN KEY (numero_agencia, numero_banco, cnpj)
REFERENCES public.agencias (numero_agencia, numero_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.lotacao ADD CONSTRAINT agencias_lotacao_fk
FOREIGN KEY (numero_agencia, numero_banco, cnpj)
REFERENCES public.agencias (numero_agencia, numero_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.servico_agencia ADD CONSTRAINT agencias_servico_agencia_fk
FOREIGN KEY (numero_agencia, numero_banco, cnpj)
REFERENCES public.agencias (numero_agencia, numero_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.lotacao_dia_horas_trabalhado ADD CONSTRAINT lotacao_lotacao_cargo_horaria_fk
FOREIGN KEY (matricula, numero_agencia, numero_banco, cnpj)
REFERENCES public.lotacao (matricula, numero_agencia, numero_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
