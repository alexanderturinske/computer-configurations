###################################
# Git aliases
###################################
alias getBranch='git rev-parse --abbrev-ref HEAD | pbcopy && echo $(pbpaste)'
alias getCommitHash='git rev-parse HEAD | pbcopy && echo $(pbpaste)'
alias gc='git commit && git status'
alias gca='git commit --amend && git status'
alias gcane='git commit --amend --no-edit && git status'
alias gcf='git commit --fixup'
alias gclean='git clean -d -f'
alias gclone='git clone'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gdrop='ga . && git stash && git stash drop'
alias gfem='git fetch -vp origin master'
alias gfemrom='gfem & grom'
alias gl='git log'
alias gl1='git log -1'
alias gl2='git log -2'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gmnfd='echo "git merge --no-ff develop" && git merge --no-ff develop'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcou='echo "git checkout master && git checkout $1 && grbm" && git checkout master && git checkout $1 && grbm'
alias gconfig.prune='echo "git config remote.origin.prune true"; git config remote.origin.prune true'
alias gconfig.push='echo "git config --global push.default current"; git config --global push.default current'
alias gpaste='echo "pbpaste | git apply"; pbpaste | git apply'
alias gpush='echo "git push origin"; git push origin'
alias gpushf='echo "git push origin --force-with-lease"; git push origin --force-with-lease'
alias gpull='echo "git pull"; git pull'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias greb='git rebase'
alias gremote='git submodule update --remote -f'
alias gres='git reset'
alias grev='git revert --no-edit'
alias greva='git revert --abort'
alias grevc='git revert --continue'
alias grhh='git reset --hard HEAD~'
alias grsh='git reset --soft HEAD~'
alias grom='git rebase origin/master'
alias gshow='git show'
alias gshowf='git show --pretty="" --name-only'
alias gs='git status'
alias gsecuritypush='echo "git push security"; git push security'
alias gsecuritypushf='echo "git push security --force-with-lease"; git push security --force-with-lease'
alias syncRemote='git fetch upstream; git checkout master; git merge upstream/master'

#===   FUNCTION   ===============================
#          NAME: gdbranch
#   DESCRIPTION: Delete current branch
#================================================
function gdbranch {
  # Get the name of the current Git branch and then ensure that only
  local branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  echo "The current branch you are on is $branch."

  # Get either a branch named `master` or `main` 
  # TODO: Generalize this by looking at the repos remote origin or something
  local mainBranch=$(git branch | cut -c 3- | grep -E '^master$|^main$')
  echo "The main branch of this directory is $mainBranch."
  # Only push this update to the server if the current branch is the Master branch
  if [[ "$branch" == "$mainBranch" ]]
  then
    echo "One cannot delete the main branch, $branch!"
  else
    echo "Deleting the $branch branch..."

    git checkout $mainBranch 
    git branch -D $branch
    echo "Finished!"
  fi
}
