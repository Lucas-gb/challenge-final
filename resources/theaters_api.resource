*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   env.resource

*** Keywords ***
Criar Sala na API
    [Documentation]    Cria uma nova sala de cinema usando a sessão de admin existente.
    [Arguments]    ${token_admin}    ${nome_da_sala}

    # Cabeçalho completo, incluindo o Content-Type
    ${headers}=      Create Dictionary
    ...    Authorization=Bearer ${token_admin}
    ...    Content-Type=application/json

    # Corpo com o tipo de dado correto para 'capacity'
    ${capacidade_int}=    Convert To Integer    150

    ${body}=         Create Dictionary
    ...    name=${nome_da_sala}
    ...    capacity=${capacidade_int}
    ...    type=IMAX

    # Usando a sessão de login para manter o contexto
    ${response}=    POST On Session
    ...    alias=auth_session
    ...    url=/theaters
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=201

    ${theater_data}=    Get From Dictionary    ${response.json()}    data
    ${theater_id}=      Get From Dictionary    ${theater_data}      _id

    RETURN    ${theater_id}