*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    env.resource

*** Keywords ***
Fazer Login e Obter Token
    [Documentation]    Realiza o login com as credenciais fornecidas e retorna o token de autorização.
    [Arguments]    ${email}    ${password}

    ${body}=    Create Dictionary    email=${email}    password=${password}
    
    Create Session    alias=auth_session    url=${BASE_URL}
    
    ${response}=    POST On Session
    ...    alias=auth_session
    ...    url=/auth/login
    ...    json=${body}
    ...    expected_status=200
    
    
    ${data}=     Get From Dictionary    ${response.json()}    data
    ${token}=    Get From Dictionary    ${data}               token
    
    RETURN    ${token}

Obter Token de Usuário Apenas
    [Documentation]    Faz um POST simples para obter o token de um usuário, sem usar ou alterar sessões existentes.
    [Arguments]    ${email}    ${password}

    ${body}=      Create Dictionary    email=${email}    password=${password}
    ${headers}=   Create Dictionary    Content-Type=application/json

    ${response}=  POST
    ...    url=${BASE_URL}/auth/login
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=200

    ${data}=    Get From Dictionary    ${response.json()}    data
    ${token}=   Get From Dictionary    ${data}    token
    RETURN      ${token}