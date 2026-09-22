# BIBLIOTECA — Banco de Dados PostgreSQL

Modelo relacional de controle de **acervo e empréstimos de uma biblioteca**, desenvolvido em **PostgreSQL** durante a disciplina de Banco de Dados.

Contém 8 tabelas, 2 views, chaves primárias e estrangeiras nomeadas, restrições `UNIQUE`, índices e sequências para IDs automáticos.

## Tabelas

| Tabela | Descrição |
|---|---|
| `aluno` | Alunos que realizam empréstimos |
| `autor` | Autores de livros |
| `categoria` | Categorias dos livros (Banco de Dados, Java, PHP, HTML) |
| `editora` | Editoras dos livros |
| `livro` | Livros do acervo |
| `emprestimo` | Empréstimos feitos por alunos (com data e valor) |
| `emprestimo_livro` | Relação N:N — livros de cada empréstimo |
| `livro_autor` | Relação N:N — autores de cada livro |

### Views

- `livro_dados` — livro com categoria e editora (JOINs)
- `livro_autor_dados` — livros com seus autores (relação N:N)

## Arquivos

```
biblioteca-postgres/
├── schema.sql    # Criação do banco: tabelas, chaves, índices, views
├── seed.sql      # Dados de exemplo (fictícios)
└── queries.sql   # Consultas de exemplo (JOINs, agregação, views)
```

## Como restaurar localmente

Requisito: PostgreSQL 12+ instalado e rodando.

**1. Criar o banco:**

```sh
createdb -U postgres biblioteca
```

**2. Aplicar o schema:**

```sh
psql -U postgres -d biblioteca -f schema.sql
```

**3. Carregar os dados de exemplo:**

```sh
psql -U postgres -d biblioteca -f seed.sql
```

**4. Testar as consultas:**

```sh
psql -U postgres -d biblioteca -f queries.sql
```

> Nos scripts acima vai ser pedida a senha do usuário `postgres`.

> Projeto de disciplina de Banco de Dados (PostgreSQL) — criação original: Gabriel Armelini.
