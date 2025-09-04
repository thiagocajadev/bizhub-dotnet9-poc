# BizHub .NET9 POC

**BizHub - Business Hub ou Cadastro de Empresas**

Olá dev. Esse projeto é apenas uma prova de conceito, testando recursos do .NET9. Vou seguir a abordagem de
desenvolvimento `API First`.

> **API First** → o design e a definição das APIs são priorizados
> antes da implementação da lógica de negócios ou da interface do usuário

## Requisitos

Instalação do **SDK** com `.NET9`.

```bash
# Configura os pacotes para instalação.
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```

```bash
# Instala o SDK
sudo apt-get update && sudo apt-get install -y dotnet-sdk-9.0
```

## Convenções

Em projetos mais recentes, aplico convenções e padrões que melhoram a leitura e escrita do código. Aqui podem entrar
alguns arquivos auxiliares configurações para o assegurar o processo de `linting`:

- `.gitignore` → Ignora pastas e arquivos que não fazem parte do projeto.
- `.editorconfig` → Define padrão de estilos, como espaçamento e indentação.
- `.husky` → Diretório com validações de commits.

> [!NOTE]
> Projetos C# utilizam a escrita em PascalCase.

## Documentação

Documentar é ajudar você mesmo no futuro. A melhor documentação que existe é um **código bem escrito e enxuto**. Nesse caso
aqui, é um passo a passo didático, servindo como apoio.

```bash
# Cria diretórios padrão para documentação e código-fonte.
mkdir docs src
````

Show! Agora é só seguir as instruções por [aqui](docs/00-index.md).
