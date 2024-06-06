#!/bin/zsh -f

if [[ -z $1 ]] {
    print "Requires arg1: commit message"
}

for i ({16..32..4}) {
    ver=v${i}
    git checkout $ver
    git merge --squash --allow-unrelated-histories -X theirs dev

    args=(
        set action.yml
        --key runs.using
        --str node${i}
        --save
    )
    tomlyre $args

    git add .
    git commit -m "$1"
    git push --set-upstream origin $ver
}

git checkout dev
