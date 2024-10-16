CREATE DATABASE bd_Banco
USE bd_Banco
GO

CREATE TABLE tbCliente (
	codCliente INT PRIMARY KEY NOT NULL,
	nomeCliente VARCHAR (50) NOT NULL,
	cpfCliente VARCHAR (11) NOT NULL
);

CREATE TABLE tbContaCorrente (
	numConta INT PRIMARY KEY NOT NULL,
	saldoConta DECIMAL(10, 2) NOT NULL,
	codCliente INT NOT NULL
	
	FOREIGN KEY (codCliente) REFERENCES tbCliente(codCliente)
);

CREATE TABLE tbDeposito (
    codDeposito INT PRIMARY KEY NOT NULL,
    valorDeposito DECIMAL(10, 2) NOT NULL,
    numConta INT NOT NULL,
    dataDeposito DATE NOT NULL,
    horaDeposito TIME NOT NULL,

    FOREIGN KEY (numConta) REFERENCES tbContaCorrente(numConta)
);

CREATE TABLE tbSaque (
    codSaque INT PRIMARY KEY NOT NULL,
    valorSaque DECIMAL(10, 2) NOT NULL,
    numConta INT NOT NULL,
    dataSaque DATE NOT NULL,
    horaSaque TIME NOT NULL,

    FOREIGN KEY (numConta) REFERENCES tbContaCorrente(numConta)
);

