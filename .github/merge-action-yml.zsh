#!/bin/zsh -f

for i ({16..32..4}) {
    ver=v${i}
    git checkout $ver
    git add .
    git merge --squash --allow-unrelated-histories -X theirs dev
    git commit -m "fix(gh-output): +EOL"
    git push --set-upstream origin $ver
}

git checkout dev
