-- ============================================================
--  BIBLIOTECA - Dados de exemplo
--  Inserções fictícias (dados de estudo, sem informação real)
--  Ordem respeita as chaves estrangeiras.
-- ============================================================

-- ---- Categorias -------------------------------------------------
INSERT INTO categoria (idcategoria, nome) VALUES (1, 'Banco de Dados');
INSERT INTO categoria (idcategoria, nome) VALUES (2, 'HTML');
INSERT INTO categoria (idcategoria, nome) VALUES (3, 'Java');
INSERT INTO categoria (idcategoria, nome) VALUES (4, 'PHP');

-- ---- Editoras ---------------------------------------------------
INSERT INTO editora (ideditora, nome) VALUES (1, 'Bookman');
INSERT INTO editora (ideditora, nome) VALUES (2, 'Edgard Blusher');
INSERT INTO editora (ideditora, nome) VALUES (3, 'Nova Terra');
INSERT INTO editora (ideditora, nome) VALUES (4, 'Brasport');

-- ---- Autores ----------------------------------------------------
INSERT INTO autor (idautor, nome) VALUES (1, 'Waldemar Setzer');
INSERT INTO autor (idautor, nome) VALUES (2, 'Flávio Soares');
INSERT INTO autor (idautor, nome) VALUES (3, 'John Watson');
INSERT INTO autor (idautor, nome) VALUES (4, 'Rui Rossi dos Santos');
INSERT INTO autor (idautor, nome) VALUES (5, 'Antonio Pereira de Resende');
INSERT INTO autor (idautor, nome) VALUES (6, 'Claudiney Calixto Lima');
INSERT INTO autor (idautor, nome) VALUES (7, 'Evandro Carlos Teruel');
INSERT INTO autor (idautor, nome) VALUES (8, 'Ian Graham');
INSERT INTO autor (idautor, nome) VALUES (9, 'Fabrício Xavier');
INSERT INTO autor (idautor, nome) VALUES (10, 'Pablo Dalloglio');

-- ---- Alunos -----------------------------------------------------
INSERT INTO aluno (idaluno, nome) VALUES (1, 'Mario');
INSERT INTO aluno (idaluno, nome) VALUES (2, 'João');
INSERT INTO aluno (idaluno, nome) VALUES (3, 'Paulo');
INSERT INTO aluno (idaluno, nome) VALUES (4, 'Pedro');
INSERT INTO aluno (idaluno, nome) VALUES (5, 'Maria');

-- ---- Livros ----------------------------------------------------
INSERT INTO livro (idlivro, ideditora, idcategoria, nome) VALUES (1, 2, 1, 'Banco de Dados - 1 Edição');
INSERT INTO livro (idlivro, ideditora, idcategoria, nome) VALUES (2, 1, 1, 'Oracle DataBase 11G Administração');
INSERT INTO livro (idlivro, ideditora, idcategoria, nome) VALUES (3, 3, 3, 'Programação de Computadores em Java');
INSERT INTO livro (idlivro, ideditora, idcategoria, nome) VALUES (4, 4, 3, 'Programação Orientada a Aspectos em Java');
INSERT INTO livro (idlivro, ideditora, idcategoria, nome) VALUES (5, 4, 2, 'HTML5 - Guia Prático');
INSERT INTO livro (idlivro, ideditora, idcategoria, nome) VALUES (6, 3, 2, 'XHTML: Guia de Referência para Desenvolvimento na Web');
INSERT INTO livro (idlivro, ideditora, idcategoria, nome) VALUES (7, 1, 4, 'PHP para Desenvolvimento Profissional');
INSERT INTO livro (idlivro, ideditora, idcategoria, nome) VALUES (8, 2, 4, 'PHP com Programação Orientada a Objetos');

-- ---- Livros x Autores (N:N) -------------------------------------
INSERT INTO livro_autor (idlivro, idautor) VALUES (1, 1);
INSERT INTO livro_autor (idlivro, idautor) VALUES (1, 2);
INSERT INTO livro_autor (idlivro, idautor) VALUES (2, 3);
INSERT INTO livro_autor (idlivro, idautor) VALUES (3, 4);
INSERT INTO livro_autor (idlivro, idautor) VALUES (4, 5);
INSERT INTO livro_autor (idlivro, idautor) VALUES (4, 6);
INSERT INTO livro_autor (idlivro, idautor) VALUES (5, 7);
INSERT INTO livro_autor (idlivro, idautor) VALUES (6, 8);
INSERT INTO livro_autor (idlivro, idautor) VALUES (7, 9);
INSERT INTO livro_autor (idlivro, idautor) VALUES (8, 10);

-- ---- Empréstimos ------------------------------------------------
INSERT INTO emprestimo (idemprestimo, idaluno, data_emprestimo, data_devolucao, valor, devolvido) VALUES (1, 1, '2012-05-02', '2012-05-12', 10.00, 'S');
INSERT INTO emprestimo (idemprestimo, idaluno, data_emprestimo, data_devolucao, valor, devolvido) VALUES (2, 1, '2012-04-23', '2012-05-03', 5.00, 'N');
INSERT INTO emprestimo (idemprestimo, idaluno, data_emprestimo, data_devolucao, valor, devolvido) VALUES (3, 2, '2012-05-10', '2012-05-20', 12.00, 'N');
INSERT INTO emprestimo (idemprestimo, idaluno, data_emprestimo, data_devolucao, valor, devolvido) VALUES (4, 3, '2012-05-10', '2012-05-20', 8.00, 'S');
INSERT INTO emprestimo (idemprestimo, idaluno, data_emprestimo, data_devolucao, valor, devolvido) VALUES (5, 4, '2012-05-05', '2012-05-15', 15.00, 'N');
INSERT INTO emprestimo (idemprestimo, idaluno, data_emprestimo, data_devolucao, valor, devolvido) VALUES (6, 4, '2012-05-07', '2012-05-17', 20.00, 'S');
INSERT INTO emprestimo (idemprestimo, idaluno, data_emprestimo, data_devolucao, valor, devolvido) VALUES (7, 4, '2012-05-08', '2012-05-18', 5.00, 'S');

-- ---- Livros de cada empréstimo (N:N) ----------------------------
INSERT INTO emprestimo_livro (idemprestimo, idlivro) VALUES (1, 1);
INSERT INTO emprestimo_livro (idemprestimo, idlivro) VALUES (2, 4);
INSERT INTO emprestimo_livro (idemprestimo, idlivro) VALUES (2, 3);
INSERT INTO emprestimo_livro (idemprestimo, idlivro) VALUES (3, 2);
INSERT INTO emprestimo_livro (idemprestimo, idlivro) VALUES (3, 7);
INSERT INTO emprestimo_livro (idemprestimo, idlivro) VALUES (4, 5);
INSERT INTO emprestimo_livro (idemprestimo, idlivro) VALUES (5, 4);
INSERT INTO emprestimo_livro (idemprestimo, idlivro) VALUES (6, 6);
INSERT INTO emprestimo_livro (idemprestimo, idlivro) VALUES (6, 1);
INSERT INTO emprestimo_livro (idemprestimo, idlivro) VALUES (7, 8);

-- ---- Sincroniza as sequências -----------------------------------
SELECT pg_catalog.setval('aluno_idaluno_seq', 5, true);
SELECT pg_catalog.setval('autor_idautor_seq', 10, true);
SELECT pg_catalog.setval('categoria_idcategoria_seq', 4, true);
SELECT pg_catalog.setval('editora_ideditora_seq', 4, true);
SELECT pg_catalog.setval('emprestimo_idemprestimo_seq', 7, true);
SELECT pg_catalog.setval('livro_idlivro_seq', 8, true);