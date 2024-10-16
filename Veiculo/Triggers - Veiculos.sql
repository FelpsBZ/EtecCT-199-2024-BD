USE bd_Veiculos

CREATE TRIGGER trg_AtualizaPontuacaoMotorista
ON tb_Multa
AFTER INSERT
AS
BEGIN
    DECLARE @idVeiculo INT;
    DECLARE @pontosMulta INT;
    DECLARE @idMotorista INT;
    DECLARE @pontuacaoAcumulada INT;

    SELECT @idVeiculo = idVeiculo, @pontosMulta = pontosMulta FROM inserted;

    SELECT @idMotorista = idMotorista FROM tb_Veiculo WHERE idVeiculo = @idVeiculo;

    SELECT @pontuacaoAcumulada = pontuacaoAcumulada FROM tb_Motorista WHERE idMotorista = @idMotorista;

    UPDATE tb_Motorista
    SET pontuacaoAcumulada = @pontuacaoAcumulada + @pontosMulta
    WHERE idMotorista = @idMotorista;

    IF (@pontuacaoAcumulada + @pontosMulta >= 20)
    BEGIN
        PRINT 'Aviso: O motorista atingiu 20 pontos e poderá ter sua habilitação suspensa.';
    END
END;

-- insert Motorista
INSERT INTO tb_Motorista (idMotorista, nomeMotorista, dataNascimentoMotorista, cpfMotorista, CNHMotorista, pontuacaoAcumulada)
VALUES (2, 'Gabriel Ortiz', '2000-07-18', '12345678901', 987654321, 10);

-- insert Veiculo
INSERT INTO tb_Veiculo (idVeiculo, modeloVeiculo, placa, renavam, anoVeiculo, idMotorista)
VALUES (2, 'Mercedes G63 AMG', 'DFG0987', '12345678910', '2015-01-01', 2);

-- insert Multa (ultrapassando 20 pontos na carteira)
INSERT INTO tb_Multa (idMulta, dataMulta, pontosMulta, idVeiculo)
VALUES (2, '2024-10-15', 12, 2);

SELECT * FROM tb_Motorista WHERE idMotorista = 2;