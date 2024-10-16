USE bd_Banco

CREATE TRIGGER trg_AtualizaSaldoDeposito
ON tbDeposito
AFTER INSERT
AS
BEGIN
    DECLARE @numConta INT;
    DECLARE @valorDeposito DECIMAL(10, 2);

    -- Obter os valores inseridos no depósito
    SELECT @numConta = numConta, @valorDeposito = valorDeposito FROM inserted;

    -- Atualizar o saldo da conta corrente somando o valor do depósito
    UPDATE tbContaCorrente
    SET saldoConta = saldoConta + @valorDeposito
    WHERE numConta = @numConta;
END;

INSERT INTO tbCliente (codCliente, nomeCliente, cpfCliente)
VALUES (1, 'Maria Souza', '12345678901');

INSERT INTO tbContaCorrente (numConta, saldoConta, codCliente)
VALUES (1001, 500.00, 1); -- Conta com saldo inicial de R$ 500,00

INSERT INTO tbDeposito (codDeposito, valorDeposito, numConta, dataDeposito, horaDeposito)
VALUES (1, 200.00, 1001, '2024-10-15', '10:30:00'); -- Depósito de R$ 200,00

SELECT * FROM tbContaCorrente WHERE numConta = 1001;




--2
CREATE TRIGGER trg_AtualizaSaldoSaque
ON tbSaque
AFTER INSERT
AS
BEGIN
    DECLARE @numConta INT;
    DECLARE @valorSaque DECIMAL(10, 2);
    DECLARE @saldoConta DECIMAL(10, 2);

    -- Obter os valores inseridos no saque
    SELECT @numConta = numConta, @valorSaque = valorSaque FROM inserted;

    -- Obter o saldo atual da conta
    SELECT @saldoConta = saldoConta FROM tbContaCorrente WHERE numConta = @numConta;

    -- Verificar se o saldo é suficiente para o saque
    IF @saldoConta >= @valorSaque
    BEGIN
        -- Atualizar o saldo descontando o valor do saque
        UPDATE tbContaCorrente
        SET saldoConta = saldoConta - @valorSaque
        WHERE numConta = @numConta;
    END
    ELSE
    BEGIN
        -- Caso não tenha saldo suficiente, lançar um erro
        RAISERROR('Saldo insuficiente para realizar o saque.', 16, 1);
        -- Opcional: Desfazer o saque inserido
        ROLLBACK;
    END;
END;

INSERT INTO tbSaque (codSaque, valorSaque, numConta, dataSaque, horaSaque)
VALUES (1, 100.00, 1001, '2024-10-16', '11:00:00'); -- Saque de R$ 100,00

SELECT * FROM tbContaCorrente WHERE numConta = 1001;



-- TESTES

-- ========================
-- Teste das Triggers
-- ========================

-- Passo 1: Inserir um cliente na tabela tbCliente
INSERT INTO tbCliente (codCliente, nomeCliente, cpfCliente)
VALUES (4, 'Carlos Roberto', '12345678901');

-- Passo 2: Inserir uma conta corrente com saldo inicial de R$ 500,00
INSERT INTO tbContaCorrente (numConta, saldoConta, codCliente)
VALUES (1004, 500.00, 4);

-- ========================
-- Teste 1: Depósitos
-- ========================
-- Passo 3: Inserir um depósito de R$ 200,00
INSERT INTO tbDeposito (codDeposito, valorDeposito, numConta, dataDeposito, horaDeposito)
VALUES (4, 200.00, 1004, '2024-10-15', '10:30:00');

-- Verificar saldo após o depósito
SELECT * FROM tbContaCorrente WHERE numConta = 1004;

-- ========================
-- Teste 2: Saques
-- ========================
-- Passo 4: Inserir um saque de R$ 100,00 (saldo suficiente)
INSERT INTO tbSaque (codSaque, valorSaque, numConta, dataSaque, horaSaque)
VALUES (4, 100.00, 1004, '2024-10-16', '11:00:00');

-- Verificar saldo após o saque
SELECT * FROM tbContaCorrente WHERE numConta = 1004;

-- ========================
-- Teste 3: Saque com Saldo Insuficiente
-- ========================
-- Passo 5: Tentativa de saque de R$ 700,00 (saldo insuficiente)
INSERT INTO tbSaque (codSaque, valorSaque, numConta, dataSaque, horaSaque)
VALUES (5, 700.00, 1004, '2024-10-17', '12:00:00');

-- Verificar se o saldo permaneceu inalterado
SELECT * FROM tbContaCorrente WHERE numConta = 1004;
