# Fundação

Primeiro, vamos estruturar os diretórios e arquivos com o código-fonte, separando o **backend** e
**frontend**.

- **Back-end (Backend):** tudo que roda no **servidor**, responsável por regras de negócio, persistência de dados,
autenticação e APIs. O front só consome o que o backend expõe.

- **Front-end (Frontend):** tudo que roda no **cliente** (navegador ou app), responsável por interface, interação
com o usuário e apresentação dos dados recebidos do backend.

Por que fazer isso?

- `API` e `UI` totalmente desacoplados → comunicação via HTTP.
- `DTOs da API` separados dos `ViewModels` da `UI` → evita acoplamento e mantém flexível.
- `Models` do domínio só no `backend` → regras de negócio protegidas.
- `UI` e `API` podem ser versionados e publicados separadamente.

```bash
# Acessa o diretório source e cria as demais pastas
cd src/
mkdir backend frontend tests
```

## Design por contexto

Cada projeto deve ser separado em camadas. Essa segregação é feita com base no **contexto de responsabilidade**. Assim
temos uma estrutura flexivel para crescimento e manutenção saudável da aplicação.

Estrutura do Backend:

```bash
cd src/backend/

# API (entrada + controllers). Esse é o nosso executável que roda no servidor web.
dotnet new webapi -n BizHub.API

# Domain (entidades, interfaces). Organização e representação das regras de negócios.
dotnet new classlib -n BizHub.Models

# Infra (repos, factory, db, serviços externos). Tecnologias usadas no projeto.
dotnet new classlib -n BizHub.Infra
```

Estrutura do Frontend:

```bash
cd src/frontend/

# UI com Razor Pages
dotnet new webapp -n BizHub.UI

# Domain/Models, ViewModels ou DTOs. Há muitas formas de chamar.
# São apenas as regras de negócio que vão ser exibidas na tela.
# Definição de ViewModels: objetos da UI que adaptam dados da API para exibição ou inputs do usuário.
dotnet new classlib -n BizHub.ViewModels
```

Estrutura para Testes:

```bash
cd src/tests/

# Testes de integração.
dotnet new xunit -n BizHub.API.Tests

# Testes na tela
dotnet new xunit -n BizHub.UI.Tests
```

Beleza! A estrutura inicial foi criada, agora é a hora de organizar a estrutura lógica com uma **Solution**.

# Criando Solutions

No Csharp, criamos `solutions` que são arquivos do tipo `sln`. Elas servem para **abraçar** os **projetos que compõe
o projeto principal**, facilitando as referências e uso com seu editor (IDE).

Criando e referênciando projetos na Solution:

```bash
# Cria a solution única
dotnet new sln -n BizHub

# Adiciona projetos do backend
dotnet sln add src/backend/BizHub.API/BizHub.API.csproj
dotnet sln add src/backend/BizHub.Infra/BizHub.Infra.csproj
dotnet sln add src/backend/BizHub.Models/BizHub.Models.csproj

# Adiciona projetos do frontend
dotnet sln add src/frontend/BizHub.UI/BizHub.UI.csproj
dotnet sln add src/frontend/BizHub.ViewModels/BizHub.ViewModels.csproj

# Adiciona projetos de testes
dotnet sln add src/tests/BizHub.API.Tests/BizHub.API.Tests.csproj
dotnet sln add src/tests/BizHub.UI.Tests/BizHub.UI.Tests.csproj
```

Vinculando as dependências entre os projetos:

```bash
# Infra depende de Models (Entities e interfaces)
dotnet add src/backend/BizHub.Infra reference src/backend/BizHub.Models

# API depende de Models e Infra
dotnet add src/backend/BizHub.API reference src/backend/BizHub.Models
dotnet add src/backend/BizHub.API reference src/backend/BizHub.Infra

# UI depende de ViewModels (e opcionalmente Models, se quiser compartilhar algum DTO)
dotnet add src/frontend/BizHub.UI reference src/frontend/BizHub.ViewModels

# Testes dependem de projetos que testam
dotnet add src/tests/BizHub.API.Tests reference src/backend/BizHub.API
dotnet add src/tests/BizHub.API.Tests reference src/backend/BizHub.Infra
dotnet add src/tests/BizHub.API.Tests reference src/backend/BizHub.Models

dotnet add src/tests/BizHub.UI.Tests reference src/frontend/BizHub.UI
dotnet add src/tests/BizHub.UI.Tests reference src/frontend/BizHub.ViewModels
```

Analisando a organização em diretórios, ficou assim:

```tree
BizHub
├─ .git
├─ .idea
├─ docs
├─ src
│   ├─ backend
│   │   ├─ BizHub.API           # API First + Controllers
│   │   ├─ BizHub.Infra         # Repositórios, serviços, factory de DI
│   │   └─ BizHub.Models        # Entidades e interfaces de domínio
│   └─ frontend
│       ├─ BizHub.UI            # Razor Pages / Blazor
│       └─ BizHub.ViewModels    # DTOs/ViewModels da UI
├─ tests
│   ├─ BizHub.API.Tests         # Testes unitários e integração da API
│   └─ BizHub.UI.Tests          # Testes da UI
├─ BizHub.sln                    # Solution única
├─ .editorconfig
├─ .gitignore
└─ README.md
```
