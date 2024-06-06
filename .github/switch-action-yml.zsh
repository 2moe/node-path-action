#!/usr/bin/env/zsh -f

for i ({16..32..4}) {
    ver=v${i}
    git checkout --orphan=$ver
    args=(
        set action.yml
        --key runs.using
        --str node${i}
        --save
    )
    tomlyre $args
    git add .
    git commit -m "chore: update action.yml"
    git push --set-upstream origin $ver
}
