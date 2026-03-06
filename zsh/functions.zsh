# function brew() {
#   if [[ $1 == "add" ]]; then
#     # Remove the first argument ("add")
#     shift
#     # Install the package
#     command brew install "$@"
#     # Update the global Brewfile
#     command brew bundle dump --global --force
#   else
#     # Call the original brew command with all original arguments
#     command brew "$@"
#   fi
# }



# # docker compose
# function cp_docker() {
#     echo "copying docker files";
#     /bin/cp ~/projects/tsp/stg-devops-compose/docker-dependencies/* docker/
# }
#
# function cp_compose() {
#   if [[ -z "$1" ]]; then
#     echo "Service name is required" 
#   else
#     echo "copying docker-compose file for $1";
#     /bin/cp ~/projects/tsp/stg-devops-compose/bash/build/$1/* .;
#     /bin/cp ~/projects/tsp/stg-devops-compose/bash/build/.env .;
#   fi
# }

# git
function clone() {
  if [[ -z "$1" ]]; then
    echo "Repository name is required" 
  else
    echo "cloning repo stark-tech-group/$1"
    gh repo clone "stark-tech-group/$1"
  fi
}
function gcbb() {
  if [[ -z "$1" ]]; then
    echo "Branch name is required" 
  else
    echo "creating branch $1";
    git checkout -b bug/$1;
  fi
}
function gcbf() {
  if [[ -z "$1" ]]; then
    echo "Branch name is required" 
  else
    echo "creating branch $1";
    git checkout -b feature/$1;
  fi
}
function gc() {
  if [[ -z "$1" ]]; then
    echo "commit message is required" 
  else
    echo "committing $1";
    git commit -am "$1";
  fi
}
function gac() {
  if [[ -z "$1" ]]; then
    echo "commit message is required" 
  else
    echo "adding and committing $1";
    git add .;  git commit -am "$1";
  fi
}

note() {
    echo "date: $(date)" >> $HOME/drafts.txt
    echo "$@" >> $HOME/drafts.txt
    echo "" >> $HOME/drafts.txt
}

vnote() {
    echo "date: $(date)" >> $HOME/vnotes.txt
    echo "$@" >> $HOME/vnotes.txt
    echo "" >> $HOME/vnotes.txt
}


# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# pulumi blob storage
function p_azure_key(){
    export AZURE_STORAGE_KEY=$(az storage account keys list --account-name optelligentinfra --resource-group optelligent_infra --query "[0].value" -o tsv)
}
function p_azure_account(){
    export AZURE_STORAGE_ACCOUNT=optelligentinfra
}
