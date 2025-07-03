*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://api-cinema-challenge.onrender.com

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

    ${token}=    Get From Dictionary    ${response.json()}    token
    
    [Return]    ${token}