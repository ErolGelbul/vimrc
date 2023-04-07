# Vim Cheat Sheet

## Movement

### Basic
- h, l: Left, Right
- j, k: Down, Up
- H: Top of the screen
- M: Middle of the screen
- L: Bottom of the screen
- gg: Top of the document
- G: End of the document

### Word Jumps

- w: Jump forwards to the start of a word
- e: Jump forwards to the end of a word
- b: Jump backwards to the start of a word

### Line Jumps

- 0: Jump to the start of the line
- ^: Jump to the first non-blank character
- $: Jump to the end of the line.
- 5gg: Go to line 5
- CTRL + f: Page Down
- CTRL + b: Page Up

### Screen Orientation

- z + ENT: Screen on cursor top
- zz: Center screen on cursors


### Insert Mode

- i: Insert before cursor
- I: Insert at the beginning of a line
- a: Insert after the cursor
- A: Insert at the end of the line
- o: Open a new line below the current line
- O: Open a new line above the current line
- 5o: Open 5 lines and insert the same thing
- 5ia: Insert 5 a's into a line

### Editing

- r: Replace a single character.
- R: Replace more than one character until ESC is pressed.
- J: Join line below with space
- gJ: Join line below without space
- 3J: Join 3 lines below together with space
- u : Undo
- CTRL + u : Redo
- . : Repat last command
- ~ : Change case
- g~w : Change case of entire word
- g~$ OR g~~: Change case of entire line
- gUw : Force all letters in a word to uppercase
- gUU : Force all letters in a line to uppercase
- guw : Force all letters in a word to lowercase
- guu : Force all letters in a line to lowercase
- :%s/oldword/newword/g : Change all instances of the word in the file.
- :10,30s/oldword/newword

### Registers

- reg : show registers content
- "xy : yank into register x
- "xp : paste contents of register x

### Cut and Paste

- yy : copy a line
- 2yy : copy 2 lines
- y$ : copy to the end of the line
- yiw : copy the word
- p : paste the clipboard after the cursor
- P : put before the cursor
- dd : cut a line
- 2dd : cut 2 lines
- d35gg: cut from current line to line 35
- dw : cut the characters of the word
- d$ : cut to the end of the line
- x : delete character
- cw : change the word
- c$ OR C : change text till the end of the line
- cc : change entire line of text


### Save and Exit

- :w : write (save) the file, but don't exit
- :w !sudo tee % : write out the current file using sudo
- :wq : write and quit
- :q : quit
- :q! : quit and throw away unsaved changes
- :wqa : write and quit on all tabs.
 

### Comment a Block

1. Move cursor the start.
2. Ctrl+v to Visual-Block.
3. Select block w/ jk.
4. Shift+i to insert at beginning, type #.
5. Press ESC.
6. To repeat, go down, press ".".


### Replace word within lines x-y

Example: :10,20s/hello/hi/gc

- Range 10-20
- Replace "hello"
- with "hi"

Notes:

- "s" substitution command
- "g" global
- Add c at the end for confirmation
- If you want to replace it, y. If you don't want to replace it, type n. If you want to replace it and all remaining matches without asking, type a. If you want to skip this match and all remaining matches without asking, type q.