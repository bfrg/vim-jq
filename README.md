# vim-jq

Vim runtime files for [jq][jq] script files (the command-line JSON processor).

If you are looking for a Vim plugin that runs jq interactively in Vim similar to
[jqplay.org][jqplay], see [vim-jqplay][vim-jqplay].


## Syntax highlighting

#### Screenshot

<dl><p align="center">
<img src="https://user-images.githubusercontent.com/6266600/59893960-28064380-93df-11e9-9fa2-bf2933e4d6ea.png" width="480"/>
</p></dl>

(Code snippet from: [jq-zeros][jq-zeros])

#### Syntax highlighting options

```vim
" Don't highlight builtin functions/filters (default: 1)
let g:jq_highlight_builtin_functions = 0

" Don't highlight module prefix, like NAME:: (default: 1)
let g:jq_highlight_module_prefix = 0

" Don't highlight imported JSON file prefix, like $NAME:: (default: 1)
let g:jq_highlight_json_file_prefix = 0

" Highlight objects like .foo (default: 0)
let g:jq_highlight_objects = 1

" Highlight all function calls (default: 0)
" This will highlight all words directly followed by an opening parenthesis
let g:jq_highlight_function_calls = 1
```


## Mappings

* Move to next/previous function definition: <kbd>]]</kbd>, <kbd>[[</kbd>
* Move to next/previous nested function definition: <kbd>]m</kbd>,
  <kbd>\[m</kbd>
* Enhanced <kbd>gf</kbd>: when pressed on an included module path `foo/bar`
  edits the file `foo/bar.jq` if the file can be found in Vim's `'path'`,
  otherwise tries to edit `foo/bar/bar.jq`.
* Move between matching `if/elif/else/end`, `try/catch`, and function definition
  boundaries `def/;` with <kbd>%</kbd>.


## Include file searches

* Proper settings for `include`, `includeexpr`, `suffixesadd` and `define`. See
  <kbd>:h include-search</kbd> and <kbd>:h definition-search</kbd> for details.
* Jq's default search paths for [modules][jq-modules], `~/.jq` and
  `$ORIGIN/../lib/jq` (where `$ORIGIN` is the path to the `jq` executable) are
  appended to `'path'` only when they exist.


## Installation

#### Manual Installation

```bash
$ cd ~/.vim/pack/git-plugins/start
$ git clone https://github.com/bfrg/vim-jq
```
**Note:** The directory name `git-plugins` is arbitrary, you can pick any other
name. For more details see <kbd>:help packages</kbd>.

#### Plugin Managers

Assuming [vim-plug][plug] is your favorite plugin manager, add the following to
your `vimrc`:
```vim
Plug 'bfrg/vim-jq'
```


## License

Distributed under the same terms as Vim itself. See <kbd>:help license</kbd>.

[jq]: https://github.com/stedolan/jq
[jqplay]: https://jqplay.org
[vim-jqplay]: https://github.com/bfrg/vim-jqplay
[jq-zeros]: https://github.com/joelpurra/jq-zeros
[vim-matchup]: https://github.com/andymass/vim-matchup
[jq-modules]: https://stedolan.github.io/jq/manual/#Modules
[plug]: https://github.com/junegunn/vim-plug
