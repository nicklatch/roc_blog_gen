module [
    Html,
    Structure,
    Title,
    toHtml,
    getHtmlString,
    toStructure,
    getStructureString,
    el,
    escape,
]

Html := Str

Structure := Str

Title : Str

toHtml : Str -> Html
toHtml = \str ->
    @Html str

getHtmlString : Html -> Str
getHtmlString = \@Html str ->
    str

toStructure : Str -> Structure
toStructure = \str ->
    @Structure str

getStructureString : Structure -> Str
getStructureString = \@Structure content -> content

el : Str, Str -> Str
el = \tag, content ->
    "<$(tag)>$(content)</$(tag)>"

escape : Str -> Str
escape = \str ->
    str
    |> Str.toUtf8
    |> List.map \char -> escapeChar char
    |> Str.joinWith ""

escapeChar = \char ->
    when char is
        '<' -> "&lt;"
        '>' -> "&gt;"
        '&' -> "&amp;"
        '"' -> "&quot;"
        '\'' -> "&#39;"
        _ -> Str.fromUtf8 [char] |> Result.withDefault "error"
