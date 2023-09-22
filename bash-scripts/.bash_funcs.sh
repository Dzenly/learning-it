RED='\033[0;31m'
NC='\033[0m' # No Color

err() {
  >&2 printf "${RED} $* ${NC}\n"
}

cgc() {
  if [[ "$1" == "$(git rev-parse --abbrev-ref HEAD)" ]]; then
    return 0
  else
    return 1
  fi
}

com2() {
  git commit -a -m "$*" && git push
  # --no-verify
  # git pull --rebase=false
}

dra() {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
}

dr1() {
  docker run --rm -it $1
}

dr2() {
  docker run --rm -it --entrypoint $2 $1
}

gc() {
  git fetch origin $1 && git checkout $1 && cgc $1 && git reset --hard origin/$1
  return $?
}

gcb(){
	git checkout -b $1 && git push --set-upstream origin $1
}

gcp() {
  #set -e
  gc $1 && git pull
  #set +e
}

gct1(){
  git tag $1
  git push --tags
}

gdb1(){
  git branch -D $1
  git push origin --delete $1
  git remote prune origin
  git fetch --prune
}

gd() {
  clear && git diff $*
}

gdt1(){
  git tag -d $1
  git push --delete origin $1
}

gl() {
  #TZ=UTC
  git log --date=local
}

gm() {
  git fetch origin $1 && git merge origin/$1 --no-edit && git status
}

## --no-verify

gmn() {
	git commit $1 --no-edit --no-verify
}

gs() {
  clear && git status $*
}

gp() {
  git pull $*
}

# am1() {
#   cd ~/.ssh && ssh-copy-id -o PreferredAuthentications=password -o PubkeyAuthentication=no -i bb_rsa.pub root@$1
# }
#
# ssp() {
#   ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no $*
# }

gco() {
  git checkout --ours "$@"
}

k() {
  minikube kubectl -- "$@"
}

m() {
  minikube "$@"
}