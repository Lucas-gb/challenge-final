*** Settings ***
Resource    ../resources/auth_keywords.resource

*** Test Cases ***
CT-SMOKE-01: Admin Login com Sucesso
    [Documentation]    Verifica se um usuário admin consegue fazer login e receber um token.
    [Tags]    Smoke    Authentication

    ${token}=    Fazer Login e Obter Token
    ...    email=admin_teste3876@dominio.com
    ...    password=senhaAdmin3876

    Log To Console    \nToken de Admin Obtido: ${token}
    Should Not Be Empty    ${token}    msg=O token retornado estava vazio.