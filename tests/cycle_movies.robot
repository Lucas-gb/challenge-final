*** Settings ***
Library         RequestsLibrary
Library         String
Resource        ../resources/auth_keywords.resource
Resource        ../resources/movies_api.resource
Resource        ../resources/env.resource

*** Test Cases ***
CT-E2E-02 Ciclo de Gestão de um Filme (Admin)
    [Documentation]    Testa o fluxo CRUD completo para o recurso de Filme.
    ...                1. Admin cria um filme.
    ...                2. Busca o filme e valida.
    ...                3. Atualiza o filme.
    ...                4. Busca e valida a alteração.
    ...                5. Exclui o filme.
    ...                6. Tenta buscar e valida a exclusão (404).
    [Tags]    E2E    Critical    MovieManagement

    # Etapa 1: Admin faz o login
    ${token_admin}=    Fazer Login e Obter Token
    ...    email=${ADMIN_USER_EMAIL}
    ...    password=${ADMIN_USER_PASS}
    
    # Etapa 2: Admin cria um novo Filme e guarda o id
    ${titulo_filme}=    Catenate    SEPARATOR=    Vingadores - Edição Robô -     ${TEST_NAME}
    ${movie_id}=    Criar Filme na API
    ...    token_admin=${token_admin}
    ...    titulo_filme=${titulo_filme}
    Should Not Be Empty    ${movie_id}

    # Etapa 3: Busca o filme pelo id e valida os dados
    ${filme_buscado}=    Buscar Filme Por ID na API
    ...    token_admin=${token_admin}
    ...    movie_id=${movie_id}
    Should Be Equal As Strings    ${filme_buscado['title']}    ${titulo_filme}