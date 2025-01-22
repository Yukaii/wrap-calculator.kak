# wrap-calculator.kak

A soft-wrapping movement workaround plugin for kakoune.

## Installation

With [kak-bundle](https://codeberg.org/jdugan6240/kak-bundle):

```kak
bundle wrap-calculator https://github.com/Yukaii/wrap-calculator.kak %{
  map global user J ':unset-j<ret>' -docstring 'Line move down'
  map global user K ':unset-k<ret>' -docstring 'Line move up'
}
```

## Demo

[![asciicast](https://asciinema.org/a/699327.svg)](https://asciinema.org/a/699327)

## License

MIT
