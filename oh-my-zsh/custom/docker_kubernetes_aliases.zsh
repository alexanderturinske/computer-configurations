###################################
# Docker/Kubernetes aliases
###################################
#alias kbciliumexec='kubectl exec -it -n gitlab-managed-apps -c cilium-agent cilium-xvzn2 -- /bin/bash'
#alias kbnamespaces='kubectl get svc --all-namespaces'
#alias kbpods='kubectl -n gitlab-managed-apps get pods --watch'
#alias kbprometheus='docker run -p 9090:9090 -v ~/gitlab-development-kit/prometheus/prometheus.yml prom/prometheus'
#alias kbstartold='minikube start --memory=8192 --cpus=4 --insecure-registry="172.16.123.1:5000" --network-plugin=cni  --driver=hyperkit --cni=false'
#alias kbstart='minikube start --memory=5924 --cpus=2 --insecure-registry="172.16.123.1:5000" --network-plugin=cni --cni=false'
#alias kbstop='minikube stop'
alias kbtest='echo "ruby ~/env.rb" && ruby ~/env.rb'
#alias kbviewpolicies='echo "kbciliumexec && cilium policy get"'

###################################
# Docker Machine 
###################################
# ping 192.168.99.1 in the runner to check connectivity
# alias glrunner_start='gtlbd && dms && gitlab-runner --log-level debug run --config ~/gitlab-development-kit/gitlab-runner-config.toml'

