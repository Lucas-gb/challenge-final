# challenge-final
Projeto de automação de testes front e backend.

# Automação de Testes de API - Challenge Final

Este repositório contém um projeto de automação de testes para uma API de gerenciamento de cinema, cobrindo as principais funcionalidades do sistema. O projeto foi desenvolvido utilizando Robot Framework e Python.

## 🚀 Sobre o Projeto

O objetivo deste projeto é validar os endpoints da API, garantindo o funcionamento correto das operações de CRUD (Create, Read, Update, Delete) para os principais recursos da aplicação, como Filmes, Sessões, Teatros e Reservas.

Os testes são estruturados para cobrir tanto cenários de sucesso (caminho feliz) quanto cenários de falha (testes negativos), além de validar regras de negócio como permissões de acesso para usuários comuns e administradores.

## 🛠️ Tecnologias Utilizadas

* **Linguagem:** Python 3
* **Framework de Teste:** Robot Framework
* **Gerenciador de Pacotes:** Pip
* **Dependências Principais:**
    * `robotframework`
    * `robotframework-requests`
    * `robotframework-jsonlibrary`

## ✨ Funcionalidades Testadas

O projeto de automação cobre os seguintes módulos da API:

* **Autenticação:** Testes de registro e login de usuários (comum e admin).
* **Setup:** Criação e registro de login(comum e admin).
* **Filmes:** Validação do CRUD de filmes.
* **Teatros:** Validação do CRUD de teatros/salas.
* **Sessões:** Validação do CRUD de sessões de filmes.
* **Reservas:** Testes de criação de reservas por usuários e validação de regras de negócio (reservas com sessões inválidas, etc).
* **Usuarios:** Validação e testes de cadastro (comum e admin).

## 📂 Estrutura dos Testes

Os testes estão organizados da seguinte forma:

* `tests/smoke_tests.robot`: Um conjunto de testes rápidos para validar a saúde geral da API.
* `tests/cycle_movies.robot`: Suíte de testes focada no ciclo de vida e gerenciamento de filmes.
* `tests/cycle_reservation.robot`: Suíte de testes focada no fluxo de criação e validação de reservas.

## ⚙️ Pré-requisitos e Instalação

Antes de começar, você precisará ter o [Python 3](https://www.python.org/downloads/) instalado.

1.  **Clone o repositório:**
    ```bash
    git clone <URL_DO_SEU_REPOSITORIO_NO_GITHUB>
    cd challenge-final
    ```

2.  **Crie e ative um ambiente virtual (recomendado):**
    ```bash
    # Criar o ambiente
    python -m venv venv

    # Ativar no Windows
    .\venv\Scripts\activate

    # Ativar no macOS/Linux
    source venv/bin/activate
    ```

3.  **Instale as dependências do projeto:**
    ```bash
    pip install -r requirements.txt
    ```

## ▶️ Como Executar os Testes

Para executar os testes, utilize o comando `robot` a partir da raiz do projeto.

1.  **Para executar todos os testes de uma vez:**
    ```bash
    robot tests/
    ```

2.  **Para executar uma suíte de testes específica (ex: smoke tests):**
    ```bash
    robot -d results tests/smoke_tests.robot
    ```

Os resultados dos testes, incluindo logs e relatórios, serão gerados na pasta `results/`.

---
*Este projeto foi desenvolvido como parte de um desafio de automação de testes.*

## 👨‍💻 Autor
Feito por Lucas-gb 👋

## 🙏 Agradecimentos

Gostaria de agradecer aos meus colegas [Rodrigo Matuz](https://github.com/Rodrigo-Matuz) e [Wesley Cassio](https://github.com/Casx1) pelo apoio, troca de ideias e ajuda na resolução de dúvidas durante o desenvolvimento deste desafio.

