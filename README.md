# Gdiffo - a git diff optimizer

Gdiffo aims to make `git diff` easy to use with the keyboard, especially when files are in deeply nested folders.


## Examples

Let's say you run `git status` and get a long list like this one:

```
$ git status
...
Changed: app/code/../Controller/Index.xyz
Changed: app/code/../Model/File.xyz
Changed: app/view/../Layout.xyz
```

Now you can run `gdiffo` to get the diff of a specific files. Let's say you want the Index Controller:
```
gdiffo.sh 1
gdiffo.sh index
```

`gdiffo.sh 1` will run git diff for the first file.

`gdiffo.sh index` will run git diff based on case insensitive search.

Also, you can run `gdiffo` for multiple files.
```
gdiffo.sh 1,3
gdiffo.sh 1-2,3
```

## Requirements

* **git** (tested with version 2.45.0)
* **sed** (tested with version 4.9)
* **awk** (tested with version 5.3.0)

## Create a git alias

Open `~/.gitconfig` with your favorite text editor and add

```
[alias]
    diffo = "!bash YOUR_PATH/gdiffo.sh"
```

Change `YOUR_PATH` to the path of the Gdiffo repository.

Now you can run `git diffo` to run Gdiffo.
