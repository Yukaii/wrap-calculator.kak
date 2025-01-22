declare-option -hidden str wrap_calculator_script_path %val{source}

define-command -hidden wrap-calc -params 4 %{
  evaluate-commands %sh{
    cmd="${kak_opt_wrap_calculator_script_path%/*}/wrap-calculator"
    line_content="$kak_selection"
    new_pos=$(echo "$line_content" | $cmd \
      --width="$1" \
      --pos="$2" \
      --move="$4" \
      --count=1 \
      --word \
      --indent)

    # Restore original selection first
    printf "execute-keys ':select %s<ret>';" "$3"

    # Move cursor to new position
    line_number=$(echo "$3" | cut -d',' -f1 | cut -d'.' -f1)
    printf "execute-keys ':select %s.%d,%s.%d<ret>';" "$line_number" "$new_pos" "$line_number" "$new_pos"

    # Debug info
    # printf 'info -title wrap-calc %%{width: %d, pos: %d, new_pos: %d, line_number: %d, sel: %s}' \
      # "$1" "$2" "$new_pos" "$line_number" "$3"
    # printf 'info -title wrap-calc %%{width: %d, pos: %d, new_pos: %d, line_number: %d, sel: %s\nline: %%{%s}}' \
    #   "$1" "$2" "$new_pos" "$line_number" "$3" "$line_content"
  }
}

# Wrap line movement down
define-command -hidden unset-move -params 1 %{
  evaluate-commands %sh{
    # Get total line count to calculate gutter width
    gutter_width=$(echo "$kak_buf_line_count" | wc -c)

    # Add 2 for padding and git status
    total_offset=$((gutter_width + 1))

    # Calculate effective window width
    window_width=$((kak_window_width - total_offset))

    # Store current selection
    saved_selection="$kak_selection_desc"
    cursor_char=$(echo "$saved_selection" | cut -d',' -f1 | cut -d'.' -f2)

    printf "execute-keys '<esc>x'; wrap-calc %%{%d} %%{%d} %%{%s} $1" \
      "$window_width" "$cursor_char" "$saved_selection"
  }
}

define-command -hidden unset-j %{ unset-move "down" }
define-command -hidden unset-k %{ unset-move "up" }
