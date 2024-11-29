const createTable = '''
CREATE TABLE contato(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);
''';

const insertContatos = '''
INSERT INTO contato (nome, email, telefone) VALUES
    ('Allyson', 'ally@GMAIL.com', '62999336784'),
    ('Day', 'day@GMAIL.com', '62912345678'),
    ('Larissa', 'lari@GMAIL.com', '62912345678')
;
''';
