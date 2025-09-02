###################################
# NPM aliases
###################################
# Increase amount of space
# export NODE_OPTIONS=--max_old_space_size=4096
alias naudit='npm install npm@latests -g; npm audit --registry https://registry.npmjs.org'
alias nlink='echo "npm link"; npm link'
alias nnuke='echo "rm node modules; npm install"; rm -rf node_modules/; npm install'
alias nnukebuild='echo "rm node modules; ppd"; rm -rf node_modules/; ppd'
alias nnukelink='echo "rm node modules; npm link"; rm -rf node_modules/; npm link'
alias findnpmlinks='echo "find node_modules -maxdepth 1 -type l -ls"; find node_modules -maxdepth 1 -type l -ls'
alias nview='echo "npm view <PACKAGE_NAME> versions"'
alias publish='npm config set registry https://artifactory.cnc-services.ci.pixsystem.net/artifactory/api/npm/pix-npm-local/ && npm login && npm publish && npm config set registry https://npm.pixsystem.net/'
