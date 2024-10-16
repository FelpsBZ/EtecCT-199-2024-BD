CREATE DATABASE bd_Veiculos
USE bd_Veiculos
GO
DROP DATABASE bd_Veiculos

CREATE TABLE tb_Motorista (
	idMotorista INT PRIMARY KEY NOT NULL,
	nomeMotorista VARCHAR(50) NOT NULL,
	dataNascimentoMotorista DATE NOT NULL,
	cpfMotorista VARCHAR(11) NOT NULL,
	CNHMotorista INT NOT NULL,
	pontuacaoAcumulada INT NOT NULL
);
SELECT * FROM tb_Motorista

CREATE TABLE tb_Veiculo (
	idVeiculo INT PRIMARY KEY NOT NULL,
	modeloVeiculo VARCHAR(50) NOT NULL,
	placa VARCHAR(7) NOT NULL,
	renavam VARCHAR(11) NOT NULL,
	anoVeiculo DATE NOT NULL,
	idMotorista INT NOT NULL,

	FOREIGN KEY (idMotorista) REFERENCES tb_Motorista(idMotorista)
);
SELECT * FROM tb_Veiculo

CREATE TABLE tb_Multa (
	idMulta INT PRIMARY KEY NOT NULL,
	dataMulta DATE NOT NULL,
	pontosMulta INT NOT NULL,
	idVeiculo INT NOT NULL,

	FOREIGN KEY (idVeiculo) REFERENCES tb_Veiculo(idVeiculo)
);
SELECT * FROM tb_Multa

INSERT INTO tb_Motorista (idMotorista, nomeMotorista, dataNascimentoMotorista, cpfMotorista, CNHMotorista, pontuacaoAcumulada)
VALUES (1, 'João Silva', '1985-05-20', '12345678901', 987654321, 10);

INSERT INTO tb_Veiculo (idVeiculo, modeloVeiculo, placa, renavam, anoVeiculo, idMotorista)
VALUES (1, 'Ford Focus', 'ABC1234', '12345678910', '2015-01-01', 1);

INSERT INTO tb_Multa (idMulta, dataMulta, pontosMulta, idVeiculo)
VALUES (1, '2024-10-15', 12, 1);


