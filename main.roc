app [main] {
    cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.12.0/Lb8EgiejTUzbggO2HVVuPJFkwvvsfW6LojkLR20kTVE.tar.br",
}

import cli.Task exposing [Task]
import cli.Task
import cli.Stdout
import Html exposing [
    htmlTag,
    p,
    h1,
    append,
    render,
]

main : Task {} [Exit I32 Str]
main = run |> Task.mapErr handleErr

run : Task {} [StdoutErr _]
run =
    htmlTag
        "My title"
        (
            append
                (h1 "Heading")
                (
                    append
                        (p "<Paragraph #1>")
                        (p "<Paragraph #2>")
                )
        )
        |> render
        |> Stdout.line!

handleErr = \err ->
    when err is
        StdoutErr _ -> Exit 1 "Stdout Error"
