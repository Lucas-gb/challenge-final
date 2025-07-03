*** Settings ***
Resource    ../resources/auth_keywords.resource
Resource    ../resources/env.resource

*** Test Cases ***
CT-SMOKE-01: Admin Login com Sucesso
    [Documentation]    Verifica se um usuário admin consegue fazer login e receber um token.
    [Tags]    Smoke    Authentication

    ${token}=    Fazer Login e Obter Token
    ...    email=${ADMIN_USER_EMAIL}
    ...    password=${ADMIN_USER_PASS}

    Log To Console    \nToken de Admin Obtido: ${token}
    Should Not Be Empty    ${token}    msg=O token retornado estava vazio.