###################################
# GitLab aliases
###################################

# Navigation
alias gtlb='cd ~/gitlab-development-kit/gitlab && pwd'
alias gtlbd='cd ~/gitlab-development-kit && pwd'
alias gtlbdb='gtlbd && gdk psql -d gitlabhq_development'
alias glui='cd ~/other/gitlab-ui && pwd'
alias glvscode='cd ~/other/gitlab-vscode-extension && pwd'
export GITLAB_HOME='/Users/aturinske/gitlab-development-kit/gitlab'

# GTLBD
alias gdk_fullrestart='gtlbd && gdk stop && git pull && gdk update && gdk reconfigure && gdk start'
alias gdk_restart='gdk stop && gdk kill && gdk start'
alias glkillrails="ps -ef | grep 'rails-background-jobs' | grep -v grep | awk '{print $2}' | xargs kill -9"
alias glkillruby="pkill ruby"
alias glrails='gdk stop rails-background-jobs && services/rails-background-jobs/run'

# GTLB processes
alias glbackport='bin/secpick'
alias gldanger='bin/rake danger_local'
alias gldbgco='echo "gco db/structure.sql" && gco db/structure.sql'
alias glfeatureflag='echo "bin/feature-flag" && bin/feature-flag'
alias glgpg='echo "pkill -9 gpg-agent" && pkill -9 gpg-agent'
alias glgraphqldocs='echo "bundle exec rake gitlab:graphql:compile_docs" && bundle exec rake gitlab:graphql:compile_docs'
alias gldbmigrate='echo "gtlb && bundle exec rails db:migrate" && gtlb && bundle exec rails db:migrate'
alias glpot='echo "tooling/bin/gettext_extractor locale/gitlab.pot" && tooling/bin/gettext_extractor locale/gitlab.pot'
alias glpotpush='echo "glpot && ga . && gcane && gpush" && glpot && ga . && gcane && gpush'
alias glrunner='echo "use gitlab-runner command"'
alias glsecurity='echo "scripts/security-harness" && scripts/security-harness'
alias glstart='echo "gcom && gpull && yarn && bundle install && gdk start && gldbmigrate && glresetmain" && gcom && gpull && yarn && bundle install && gdk start && gldbmigrate && glresetmain'

# Repository
alias glstyle='bundle exec lefthook run pre-push'
alias glstyleall='yarn prettier-all; yarn eslint'
alias glstylerubyall='echo "bundle exec rubocop --parallel path/to/file"'
alias glresetmain='echo "gldbgco && gbda" && gldbgco && gbda'
alias gpushi='echo "LEFTHOOK=0 git push origin"; LEFTHOOK=0 git push origin'
alias gpushfi='echo "LEFTHOOK=0 git push origin --force-with-lease"; LEFTHOOK=0 git push origin --force-with-lease'
alias glpushallf='echo "ga . && gcane && gpushf"; ga . && gcane && gpushf'

# Documentation
alias glshrinkimage='echo "pngquant" && pngquant'

# Testing
alias glj='echo "yarn jest ./path/to/tests" && yarn jest'
alias glj3='echo "VUE_VERSION=3 yarn jest ./path/to/tests" && VUE_VERSION=3 yarn jest'
alias glrspec='echo "bin/rspec ./path/to/tests:420" && bin/rspec'
# gle2e docs: https://docs.gitlab.com/ee/development/testing_guide/end_to_end/beginners_guide.html#run-the-spec
alias gle2e="echo 'gtlb && cd qa && GITLAB_PASSWORD=timetoshred bundle exec bin/qa Test::Instance::All http://gdk.test:3443/ -- qa/specs/features/ee/browser_ui/path/to/file' && GITLAB_PASSWORD='timetoshred' bundle exec bin/qa Test::Instance::All http://gdk.test:3443/ -- "

# Rails
alias glshowgroupsecurityrailsendpoints='bin/rails routes -c groups/security --expanded'
alias glshowrailsendpoints='bundle exec rake routes'
alias featureflaginfo='echo "gtlb && rails c && Feature.enable(:threat_monitoring_alerts) && Feature.disable(:threat_monitoring_alerts)"'
alias findrailspage='echo "search for document.body.dataset.page in the console"'
alias showgrouproutes='echo "bin/rails routes -c groups/security --expanded"'

# Govern
alias glcheckenv='ruby ~/env.rb'

###################################
# GitLab functions
###################################

#===   FUNCTION   ===============================
#          NAME: glcreatealerts
#   DESCRIPTION: Seeds the alerts DB with alerts
#   PARAMETER 1: URI
#   PARAMETER 2: Token
#   PARAMETER 3: Number of alerts
#==================================
function glcreatealerts {
    local uri=$1
    local token=$2
    local numOfAlerts=$3
    alertSeverity=("critical" "medium" "low" "high" "info")
    alertStatus=("TRIGGERED" "RESOLVED" "ACKNOWLEDGED" "IGNORED")
    severityLength=${#alertSeverity[@]}
    statusLength=${#alertStatus[@]}

    echo "Calling URI (POST): " ${uri}
    echo "Using token: " ${token}
    echo "Number of alerts: " ${numOfAlerts}

    for i in $(seq 1 ${numOfAlerts}); do
      randomSeverity=${alertSeverity[$(shuf -i 1-${severityLength} -n 1)]}
      randomStatus=${alertStatus[$(shuf -i 1-${statusLength} -n 1)]}
      echo "Creating alert with severity ${randomSeverity} and status ${randomStatus}"
      curl --location --request POST "${uri}" --header 'Content-Type: application/json' \
        --header "Authorization: Bearer ${token}" \
        --data-raw '{
          "title": "Available memory capacity exceeding '${i}'0% limit",
          "description": "Available memory capacity on instance ac-'${i}' requires attention",
          "service": "service not affected",
          "monitoring_tool": "CiliumInternal",
          "severity": "'${randomSeverity}'",
          "host": "am-'${i}'",
          "status": "'${randomStatus}'",
          "domain": "threat_monitoring"
        }'
    done;
} 

#===   FUNCTION   ===============================
#          NAME: glverify
#   DESCRIPTION: Checkout branch to verify changes
#   PARAMETER 1: URL of MR to verify
#   PARAMETER 2: Branch of MR to verify
#==================================
function glverify {
    local branchToMR=$1
    local urlToMR=$2

    gtlb

    if [[ "$urlToMR" ]]; then
        echo "Curling URL $urlToMR"
        curl $urlToMR.diff | git apply
        git add --all
    else
        echo "Switching to the branch $branchToMR"
        git switch $branchToMR
    fi
}


#===   FUNCTION   ===============================
#          NAME: vue-3-error-scan
#   DESCRIPTION: Show file-specific Vue3 errors for jest tests
#   PARAMETER 1: Path to file
#   PARAMETER 2: Get data from compatibility scanner online (results may be out of date)
#==================================
function vue-3-error-scan {
    local filePath=$1
    local showOnlineResults=$2

    if [[ "$showOnlineResults" ]]; then
        curl -s "https://gitlab-org.gitlab.io/frontend/playground/vue-compat-scanner/$(curl -s 'https://gitlab-org.gitlab.io/frontend/playground/vue-compat-scanner/scans.json' | jq --raw-output '.current.file')" | jq -r ".results[] | select(.extra.severity == \"ERROR\") | select(.path == \"$filePath\")"
    else
        # from https://gitlab.com/gitlab-org/frontend/playground/vue-compat-scanner
        semgrep -c https://gitlab-org.gitlab.io/frontend/playground/vue-compat-scanner/vcs-rules.yml $filePath --severity ERROR
    fi
}


# GDK autocomplete
autoload bashcompinit
bashcompinit

source ~/gitlab-development-kit/support/completions/gdk.bash
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

