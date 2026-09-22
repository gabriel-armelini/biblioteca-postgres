-- ============================================================
--  BIBLIOTECA - Exemplos de consultas
--  Demonstra o uso do schema com JOINs e as views criadas.
-- ============================================================

-- 1) Livros com categoria e editora (usando a view livro_dados)
SELECT * FROM livro_dados;

-- 2) Livros e seus autores (usando a view livro_autor_dados)
SELECT * FROM livro_autor_dados;

-- 3) Empréstimos ainda NÃO devolvidos (JOIN aluno x emprestimo)
SELECT a.nome AS aluno,
       e.data_emprestimo,
       e.data_devolucao,
       e.valor
FROM emprestimo e
JOIN aluno a ON (a.idaluno = e.idaluno)
WHERE e.devolvido = 'N';

-- 4) Quantos livros cada aluno pegou emprestado (agregação)
SELECT a.nome AS aluno, COUNT(el.idlivro) AS total_livros
FROM aluno a
JOIN emprestimo e       ON (e.idaluno = a.idaluno)
JOIN emprestimo_livro el ON (el.idemprestimo = e.idemprestimo)
GROUP BY a.nome
ORDER BY total_livros DESC;

-- 5) Total arrecadado em empréstimos por aluno
SELECT a.nome AS aluno, SUM(e.valor) AS total
FROM aluno a
JOIN emprestimo e ON (e.idaluno = a.idaluno)
GROUP BY a.nome
ORDER BY total DESC;

-- 6) Com qual autor cada livro foi escrito (JOIN de N:N via livro_autor)
SELECT li.nome AS livro, au.nome AS autor
FROM livro li
JOIN livro_autor la ON (la.idlivro = li.idlivro)
JOIN autor au       ON (au.idautor = la.idautor)
ORDER BY livro;