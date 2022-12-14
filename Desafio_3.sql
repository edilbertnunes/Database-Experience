-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `RazaoSocial` VARCHAR(45) NULL,
  `Cnpj` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL,
  `Categoria` VARCHAR(45) NULL,
  `Descricao` VARCHAR(255) NULL,
  `Produtocol` VARCHAR(45) NULL,
  `Valor` DECIMAL NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipo` (
  `idTipo` INT NOT NULL,
  `TipoCliente` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL,
  `StatusPedido` VARCHAR(45) NULL,
  `Descricao` VARCHAR(255) NULL,
  `Pedidocol` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Frete` FLOAT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disponibiliza Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Disponibiliza Produto` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_has_Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto_has_Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `mydb`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rela????o de Produto por pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rela????o de Produto por pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  `Quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`, `Pedido_Cliente_idCliente`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente`)
    REFERENCES `mydb`.`Pedido` (`idPedido` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Terceiro - Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Terceiro - Vendedor` (
  `idTerceiro - Vendedor` INT NOT NULL,
  `RazaoSocial` VARCHAR(45) NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idTerceiro - Vendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos por Venedor (Terceiro)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos por Venedor (Terceiro)` (
  `Produto_idProduto` INT NOT NULL,
  `Terceiro - Vendedor_idTerceiro - Vendedor` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Terceiro - Vendedor_idTerceiro - Vendedor`),
  INDEX `fk_Produto_has_Terceiro - Vendedor_Terceiro - Vendedor1_idx` (`Terceiro - Vendedor_idTerceiro - Vendedor` ASC) VISIBLE,
  INDEX `fk_Produto_has_Terceiro - Vendedor_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Terceiro - Vendedor_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Terceiro - Vendedor_Terceiro - Vendedor1`
    FOREIGN KEY (`Terceiro - Vendedor_idTerceiro - Vendedor`)
    REFERENCES `mydb`.`Terceiro - Vendedor` (`idTerceiro - Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento` (
  `idPagamento` INT NOT NULL,
  `TipoPagamento` VARCHAR(45) NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente`)
    REFERENCES `mydb`.`Pedido` (`idPedido` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Formas Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Formas Pagamento` (
  `idFormas Pagamento` INT NOT NULL,
  `Forma de Pagamento` VARCHAR(45) NULL,
  `Pagamento_idPagamento` INT NOT NULL,
  PRIMARY KEY (`idFormas Pagamento`),
  INDEX `fk_Formas Pagamento_Pagamento1_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Formas Pagamento_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `mydb`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrega` (
  `idEntrega` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `Codigo` VARCHAR(45) NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idEntrega`, `Pedido_idPedido`, `Pedido_Cliente_idCliente`),
  INDEX `fk_Entrega_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente`)
    REFERENCES `mydb`.`Pedido` (`idPedido` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Servico` (
  `idServico` INT NOT NULL,
  `Tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`idServico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipo Servico` (
  `idTipo Servico` INT NOT NULL,
  `Tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipo Servico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mecanico` (
  `idMecanico` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereco` VARCHAR(255) NULL,
  `Especialidade` VARCHAR(45) NULL,
  PRIMARY KEY (`idMecanico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Equipe` (
  `idEquipe` INT NOT NULL,
  `NomeEquipe` VARCHAR(45) NULL,
  `Servico_idServico` INT NOT NULL,
  `Mecanico_idMecanico` INT NOT NULL,
  PRIMARY KEY (`idEquipe`, `Servico_idServico`),
  INDEX `fk_Equipe_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  INDEX `fk_Equipe_Mecanico1_idx` (`Mecanico_idMecanico` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `mydb`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Mecanico1`
    FOREIGN KEY (`Mecanico_idMecanico`)
    REFERENCES `mydb`.`Mecanico` (`idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pre??o M??o de Obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pre??o M??o de Obra` (
  `idPre??o M??o de Obra` INT NOT NULL,
  `Servico` VARCHAR(45) NULL,
  `Preco` DECIMAL NULL,
  PRIMARY KEY (`idPre??o M??o de Obra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ordem de Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ordem de Servico` (
  `idOrdem de Servico` INT NOT NULL,
  `DataEmissao` DATE NULL,
  `DataEntrega` DATE NULL,
  `ValorTotal` DECIMAL NULL,
  `Status` VARCHAR(45) NULL,
  `Pre??o M??o de Obra_idPre??o M??o de Obra` INT NOT NULL,
  PRIMARY KEY (`idOrdem de Servico`),
  INDEX `fk_Ordem de Servico_Pre??o M??o de Obra1_idx` (`Pre??o M??o de Obra_idPre??o M??o de Obra` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Servico_Pre??o M??o de Obra1`
    FOREIGN KEY (`Pre??o M??o de Obra_idPre??o M??o de Obra`)
    REFERENCES `mydb`.`Pre??o M??o de Obra` (`idPre??o M??o de Obra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Itens da Ordem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Itens da Ordem` (
  `idItens da Ordem` INT NOT NULL,
  `ItensOrdem` VARCHAR(45) NULL,
  `Valor` DECIMAL NULL,
  `Ordem de Servico_idOrdem de Servico` INT NOT NULL,
  PRIMARY KEY (`idItens da Ordem`),
  INDEX `fk_Itens da Ordem_Ordem de Servico1_idx` (`Ordem de Servico_idOrdem de Servico` ASC) VISIBLE,
  CONSTRAINT `fk_Itens da Ordem_Ordem de Servico1`
    FOREIGN KEY (`Ordem de Servico_idOrdem de Servico`)
    REFERENCES `mydb`.`Ordem de Servico` (`idOrdem de Servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Veiculo` (
  `idVeiculo` INT NOT NULL,
  `Veiculo` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Tipo Servico_idTipo Servico` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`, `Tipo Servico_idTipo Servico`),
  INDEX `fk_Veiculo_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Veiculo_Tipo Servico1_idx` (`Tipo Servico_idTipo Servico` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veiculo_Tipo Servico1`
    FOREIGN KEY (`Tipo Servico_idTipo Servico`)
    REFERENCES `mydb`.`Tipo Servico` (`idTipo Servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo tem Varios Servi??os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipo tem Varios Servi??os` (
  `Tipo Servico_idTipo Servico` INT NOT NULL,
  `Servico_idServico` INT NOT NULL,
  PRIMARY KEY (`Tipo Servico_idTipo Servico`, `Servico_idServico`),
  INDEX `fk_Tipo Servico_has_Servico_Tipo Servico1_idx` (`Tipo Servico_idTipo Servico` ASC) VISIBLE,
  INDEX `fk_Tipo Servico_has_Servico_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  CONSTRAINT `fk_Tipo Servico_has_Servico_Tipo Servico1`
    FOREIGN KEY (`Tipo Servico_idTipo Servico`)
    REFERENCES `mydb`.`Tipo Servico` (`idTipo Servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tipo Servico_has_Servico_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `mydb`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ordem de Servico_has_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ordem de Servico_has_Servico` (
  `Ordem de Servico_idOrdem de Servico` INT NOT NULL,
  `Servico_idServico` INT NOT NULL,
  PRIMARY KEY (`Ordem de Servico_idOrdem de Servico`, `Servico_idServico`),
  INDEX `fk_Ordem de Servico_has_Servico_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  INDEX `fk_Ordem de Servico_has_Servico_Ordem de Servico1_idx` (`Ordem de Servico_idOrdem de Servico` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Servico_has_Servico_Ordem de Servico1`
    FOREIGN KEY (`Ordem de Servico_idOrdem de Servico`)
    REFERENCES `mydb`.`Ordem de Servico` (`idOrdem de Servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Servico_has_Servico_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `mydb`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pe??as`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pe??as` (
  `idPe??as` INT NOT NULL,
  `nomePe??a` VARCHAR(45) NULL,
  PRIMARY KEY (`idPe??as`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ordem de Servico_has_Pe??as`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ordem de Servico_has_Pe??as` (
  `Ordem de Servico_idOrdem de Servico` INT NOT NULL,
  `Pe??as_idPe??as` INT NOT NULL,
  PRIMARY KEY (`Ordem de Servico_idOrdem de Servico`, `Pe??as_idPe??as`),
  INDEX `fk_Ordem de Servico_has_Pe??as_Pe??as1_idx` (`Pe??as_idPe??as` ASC) VISIBLE,
  INDEX `fk_Ordem de Servico_has_Pe??as_Ordem de Servico1_idx` (`Ordem de Servico_idOrdem de Servico` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Servico_has_Pe??as_Ordem de Servico1`
    FOREIGN KEY (`Ordem de Servico_idOrdem de Servico`)
    REFERENCES `mydb`.`Ordem de Servico` (`idOrdem de Servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Servico_has_Pe??as_Pe??as1`
    FOREIGN KEY (`Pe??as_idPe??as`)
    REFERENCES `mydb`.`Pe??as` (`idPe??as`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




