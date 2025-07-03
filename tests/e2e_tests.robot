*** Settings ***
Resource    ../resources/auth_keywords.resource
Resource    ../resources/movies_api.resource
Resource    ../resources/env.resource
Resource    ../resources/theaters_api.resource
#Resource    ../resources/sessions_api.resource

*** Test Cases ***
CT-E2E-01: Ciclo de Vida de uma Reserva
    [Documentation]    Testa o fluxo completo, desde a criação dos dados base pelo admin até a reserva final pelo usuário.
    [Tags]    E2E   Critical

    # Etapa 1 e 2: Admin faz o login e cria um filme
    ${token_admin}=    Fazer Login e Obter Token
    ...    email=${ADMIN_USER_EMAIL}
    ...    password=${ADMIN_USER_PASS}

    ${movie_id}=    Criar Filme na API
    ...    token_admin=${token_admin}
    ...    titulo_filme=Os Vingadores - Robot Edition

    Log To Console    \nFilme criado com ID: ${movie_id}
    Should Not Be Empty    ${movie_id}

    # Etapa 3: Usando a ferramenta do novo resource
    ${theater_id}=    Criar Sala na API
    ...    token_admin=${token_admin}
    ...    nome_da_sala=Sala Definitiva 4D

    Log To Console    \nFilme criado com ID: ${movie_id}
    Log To Console    Sala criada com ID: ${theater_id}
    Should Not Be Empty    ${theater_id}
