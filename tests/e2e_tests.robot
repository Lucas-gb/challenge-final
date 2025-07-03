*** Settings ***
Library     String
Resource    ../resources/auth_keywords.resource
Resource    ../resources/movies_api.resource
Resource    ../resources/theaters_api.resource
Resource    ../resources/env.resource
Resource    ../resources/sessions_api.resource

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

    # Etapa 3: Gera um nome dinâmico e cria a sala
    ${sufixo_random}=    Generate Random String    8    [LOWER]
    ${nome_sala_unico}=  Catenate    SEPARATOR=     Sala Robot ${sufixo_random}

    ${theater_id}=    Criar Sala na API
    ...    token_admin=${token_admin}
    ...    nome_da_sala=${nome_sala_unico}    # <--- SINTAXE CORRIGIDA

    Log To Console    Sala criada com ID: ${theater_id}
    Should Not Be Empty    ${theater_id}

    # Etapa 4: Admin cria a sessão que une o filme e a sala
    ${session_id}=    Criar Sessão na API
    ...    token_admin=${token_admin}
    ...    movie_id=${movie_id}
    ...    theater_id=${theater_id}

    Log To Console    \nFilme criado com ID: ${movie_id}
    Log To Console    Sala criada com ID: ${theater_id}
    Log To Console    Sessão criada com ID: ${session_id}
    Should Not Be Empty    ${session_id}

    # Etapa 5: Usuário Comum faz o login
    ${token_usuario}=    Fazer Login e Obter Token
    ...    email=${USER_EMAIL}
    ...    password=${USER_PASS}

    Log To Console    \n--- MUDANÇA DE CONTEXTO: USUÁRIO COMUM ---
    Log To Console    Token do Usuário Comum: ${token_usuario}
    Should Not Be Empty    ${token_usuario}

    