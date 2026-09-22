-- ============================================================
--  BIBLIOTECA - Esquema do banco de dados
--  PostgreSQL 15
--  Modelo relacional de controle de acervo e empréstimos
--  de uma biblioteca.
--
--  Tabelas: aluno, autor, categoria, editora, livro,
--           emprestimo, emprestimo_livro, livro_autor
--  Views:   livro_dados, livro_autor_dados
-- ============================================================

-- Remove objetos caso o script seja executado novamente
DROP VIEW  IF EXISTS livro_autor_dados CASCADE;
DROP VIEW  IF EXISTS livro_dados      CASCADE;
DROP TABLE IF EXISTS emprestimo_livro CASCADE;
DROP TABLE IF EXISTS livro_autor      CASCADE;
DROP TABLE IF EXISTS emprestimo       CASCADE;
DROP TABLE IF EXISTS livro            CASCADE;
DROP TABLE IF EXISTS editora          CASCADE;
DROP TABLE IF EXISTS categoria        CASCADE;
DROP TABLE IF EXISTS autor            CASCADE;
DROP TABLE IF EXISTS aluno            CASCADE;

-- ------------------------------------------------------------
-- Tabelas base
-- ------------------------------------------------------------

CREATE TABLE aluno (
    idaluno integer NOT NULL,
    nome    character varying(50) NOT NULL
);

CREATE TABLE autor (
    idautor integer NOT NULL,
    nome    character varying(50) NOT NULL
);

CREATE TABLE categoria (
    idcategoria integer NOT NULL,
    nome        character varying(50) NOT NULL
);

CREATE TABLE editora (
    ideditora integer NOT NULL,
    nome      character varying(50) NOT NULL
);

CREATE TABLE livro (
    idlivro     integer NOT NULL,
    ideditora   integer NOT NULL,
    idcategoria integer NOT NULL,
    nome        character varying(150) NOT NULL
);

CREATE TABLE emprestimo (
    idemprestimo    integer NOT NULL,
    idaluno         integer NOT NULL,
    data_emprestimo date DEFAULT CURRENT_DATE NOT NULL,
    data_devolucao  date NOT NULL,
    valor           numeric(10,2) NOT NULL,
    devolvido       character(1) NOT NULL
);

-- ------------------------------------------------------------
-- Tabelas de relacionamento N:N
-- ------------------------------------------------------------

-- Livros emprestados em cada empréstimo
CREATE TABLE emprestimo_livro (
    idemprestimo integer NOT NULL,
    idlivro      integer NOT NULL
);

-- Autores de cada livro
CREATE TABLE livro_autor (
    idlivro  integer NOT NULL,
    idautor  integer NOT NULL
);

-- ------------------------------------------------------------
-- Sequências (IDs automáticos)
-- ------------------------------------------------------------

CREATE SEQUENCE aluno_idaluno_seq
    AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE aluno_idaluno_seq OWNED BY aluno.idaluno;

CREATE SEQUENCE autor_idautor_seq
    AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE autor_idautor_seq OWNED BY autor.idautor;

CREATE SEQUENCE categoria_idcategoria_seq
    AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE categoria_idcategoria_seq OWNED BY categoria.idcategoria;

CREATE SEQUENCE editora_ideditora_seq
    AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE editora_ideditora_seq OWNED BY editora.ideditora;

CREATE SEQUENCE emprestimo_idemprestimo_seq
    AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE emprestimo_idemprestimo_seq OWNED BY emprestimo.idemprestimo;

CREATE SEQUENCE livro_idlivro_seq
    AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER SEQUENCE livro_idlivro_seq OWNED BY livro.idlivro;

-- ------------------------------------------------------------
-- Valores padrão das chaves
-- ------------------------------------------------------------

ALTER TABLE ONLY aluno      ALTER COLUMN idaluno      SET DEFAULT nextval('aluno_idaluno_seq'::regclass);
ALTER TABLE ONLY autor      ALTER COLUMN idautor      SET DEFAULT nextval('autor_idautor_seq'::regclass);
ALTER TABLE ONLY categoria  ALTER COLUMN idcategoria  SET DEFAULT nextval('categoria_idcategoria_seq'::regclass);
ALTER TABLE ONLY editora    ALTER COLUMN ideditora    SET DEFAULT nextval('editora_ideditora_seq'::regclass);
ALTER TABLE ONLY emprestimo ALTER COLUMN idemprestimo SET DEFAULT nextval('emprestimo_idemprestimo_seq'::regclass);
ALTER TABLE ONLY livro      ALTER COLUMN idlivro      SET DEFAULT nextval('livro_idlivro_seq'::regclass);

-- ------------------------------------------------------------
-- Chaves primárias
-- ------------------------------------------------------------

ALTER TABLE ONLY aluno         ADD CONSTRAINT pk_aluno_idaluno                       PRIMARY KEY (idaluno);
ALTER TABLE ONLY autor         ADD CONSTRAINT pk_autor_idautor                       PRIMARY KEY (idautor);
ALTER TABLE ONLY categoria     ADD CONSTRAINT pk_categoria_idcategoria               PRIMARY KEY (idcategoria);
ALTER TABLE ONLY editora       ADD CONSTRAINT pk_editora_ideditora                   PRIMARY KEY (ideditora);
ALTER TABLE ONLY emprestimo    ADD CONSTRAINT pk_emprestimo_idemprestimo             PRIMARY KEY (idemprestimo);
ALTER TABLE ONLY livro         ADD CONSTRAINT pk_livro_idlivro                       PRIMARY KEY (idlivro);
ALTER TABLE ONLY emprestimo_livro ADD CONSTRAINT pk_emprestimo_livro_idemprestimo_idlivro PRIMARY KEY (idemprestimo, idlivro);
ALTER TABLE ONLY livro_autor   ADD CONSTRAINT pk_livro_autor_idlivro_idautor          PRIMARY KEY (idlivro, idautor);

-- ------------------------------------------------------------
-- Chaves estrangeiras
-- ------------------------------------------------------------

ALTER TABLE ONLY emprestimo
    ADD CONSTRAINT fk_emprestimo_idaluno FOREIGN KEY (idaluno) REFERENCES aluno(idaluno);

ALTER TABLE ONLY emprestimo_livro
    ADD CONSTRAINT fk_emprestimo_livro_idemprestimo FOREIGN KEY (idemprestimo) REFERENCES emprestimo(idemprestimo);
ALTER TABLE ONLY emprestimo_livro
    ADD CONSTRAINT fk_emprestimo_livro_idlivro FOREIGN KEY (idlivro) REFERENCES livro(idlivro);

ALTER TABLE ONLY livro_autor
    ADD CONSTRAINT fk_livro_autor_idlivro FOREIGN KEY (idlivro) REFERENCES livro(idlivro);
ALTER TABLE ONLY livro_autor
    ADD CONSTRAINT fk_livro_autor_idautor FOREIGN KEY (idautor) REFERENCES autor(idautor);

ALTER TABLE ONLY livro
    ADD CONSTRAINT fk_livro_idcategoria FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria);
ALTER TABLE ONLY livro
    ADD CONSTRAINT fk_livro_ideditora FOREIGN KEY (ideditora) REFERENCES editora(ideditora);

-- ------------------------------------------------------------
-- Restrições de unicidade
-- ------------------------------------------------------------

ALTER TABLE ONLY categoria ADD CONSTRAINT un_categoria_nome UNIQUE (nome);
ALTER TABLE ONLY editora   ADD CONSTRAINT un_editora_nome   UNIQUE (nome);
ALTER TABLE ONLY livro     ADD CONSTRAINT un_livro_nome     UNIQUE (nome);

-- ------------------------------------------------------------
-- Índices (busca por data de empréstimo/devolução)
-- ------------------------------------------------------------

CREATE INDEX idx_emp_data_emprestimo ON emprestimo USING btree (data_emprestimo);
CREATE INDEX idx_emp_data_devolucao  ON emprestimo USING btree (data_devolucao);

-- ------------------------------------------------------------
-- Views
-- ------------------------------------------------------------

-- Dados do livro com categoria e editora (JOINs)
CREATE VIEW livro_dados AS
    SELECT li.nome,
           ca.nome AS categoria,
           ed.nome AS editora
    FROM livro li
    LEFT JOIN categoria ca ON (li.idcategoria = ca.idcategoria)
    LEFT JOIN editora   ed ON (li.ideditora   = ed.ideditora);

-- Livros e seus autores (relação N:N via livro_autor)
CREATE VIEW livro_autor_dados AS
    SELECT li.nome AS livro,
           au.nome AS autor
    FROM livro_autor la
    LEFT JOIN livro li ON (la.idlivro = li.idlivro)
    LEFT JOIN autor au ON (la.idautor = au.idautor);