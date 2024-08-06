module [
    htmlTag,
    p,
    h1,
    append,
    render,
]

import Html.Internal exposing [
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

htmlTag : Title, Structure -> Html
htmlTag = \title, content ->
    toHtml
        (
            el
                "html"
                (
                    Str.concat
                        (el "head" (el "title" (escape title)))
                        (el "body" (getStructureString content))
                )
        )

p : Str -> Structure
p = \content ->
    el "p" (escape content) |> toStructure

## Interpolates the given content into a h1 `Structure`
h1 : Str -> Structure
h1 = \content ->
    el "h1" (escape content) |> toStructure

ul : List Structure -> Structure
ul = \items ->
    items
    |> List.map (\item -> el "li" (getStructureString item))
    |> Str.joinWith ""
    |> el "ul"
    |> toStructure

ol : List Structure -> Structure
ol = \items ->
    items
    |> List.map (\item -> el "li" (getStructureString item))
    |> Str.joinWith ""
    |> el "ol"
    |> toStructure

code : Str -> Structure
code = \content ->
    el "pre" (escape content) |> toStructure

## Appends two `Structure`s together.
append : Structure, Structure -> Structure
append = \content1, content2 ->
    toStructure "$(getStructureString content1)$(getStructureString content2)"

## Converts the given `Html` into its `Str` form for rendering.
render : Html -> Str
render = \html ->
    getHtmlString html
