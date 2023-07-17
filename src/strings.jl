c = 'x' # caracter
c = "x" # string
x = "∀ x ∃ y" # por defecto, unicode
"1 + 2 = $(1 + 2)" == "1 + 2 = 3" # interpolación de valores
re = r"^\s*(?:#|$)" # regexes (tipo Regex)
typeof(re)

match(r"^\s*(?:#|$)", "# a comment")