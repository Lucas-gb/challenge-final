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
    
    