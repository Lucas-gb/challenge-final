*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    DateTime
Resource   env.resource

*** Keywords ***
Criar Sessão na API
    [Documentation]    Cria uma nova sessão para um filme e sala específicos, usando a sessão de admin.
    [Arguments]    ${token_admin}    ${movie_id}    ${theater_id}

    ${headers}=      Create Dictionary
    ...    Authorization=Bearer ${token_admin}
    ...    Content-Type=application/json

    # Gera uma data e hora para amanhã às 20:30
    ${data_hoje}=      Get Current Date
    ${data_futura}=    Add Time To Date    ${data_hoje}    1 day    result_format=%Y-%m-%dT20:30:00.000Z

    ${preco_int}=      Convert To Integer    30
    ${meia_int}=       Convert To Integer    15

    ${body}=         Create Dictionary
    ...    movie=${movie_id}
    ...    theater=${theater_id}
    ...    datetime=${data_futura}
    ...    fullPrice=${preco_int}
    ...    halfPrice=${meia_int}

    # Usa a mesma sessão do login
    ${response}=    POST On Session
    ...    alias=auth_session
    ...    url=/sessions
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=201

    ${session_data}=    Get From Dictionary    ${response.json()}    data
    ${session_id}=      Get From Dictionary    ${session_data}      _id

    RETURN    ${session_id}

Criar Reserva Para Sessão
    [Documentation]    Cria uma reserva para uma sessão específica, usando o token do usuário.
    [Arguments]    ${token_usuario}    ${session_id}    ${numero_de_assentos}

    ${headers}=      Create Dictionary
    ...    Authorization=Bearer ${token_usuario}
    ...    Content-Type=application/json

    ${body}=         Create Dictionary
    ...    sessionId=${session_id}
    ...    seats=${numero_de_assentos}

    ${response}=     POST
    ...    url=${BASE_URL}/reservations
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=201  # Esperamos o status 201 Created

    ${dados_da_reserva}=    Get From Dictionary    ${response.json()}    data
    
    RETURN    ${dados_da_reserva}