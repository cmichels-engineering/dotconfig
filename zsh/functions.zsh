# git
function clone() {
  local org="${DOT_GH_ORG:-example-org}"
  if [[ -z "$1" ]]; then
    echo "Repository name is required" 
  else
    echo "cloning repo ${org}/$1"
    gh repo clone "${org}/$1"
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


# pulumi blob storage
function p_azure_key(){
    local account="${DOT_AZURE_STORAGE_ACCOUNT:-exampleinfra}"
    local group="${DOT_AZURE_STORAGE_GROUP:-example_infra}"
    export AZURE_STORAGE_KEY=$(az storage account keys list --account-name "$account" --resource-group "$group" --query "[0].value" -o tsv)
}
function p_azure_account(){
    export AZURE_STORAGE_ACCOUNT="${DOT_AZURE_STORAGE_ACCOUNT:-exampleinfra}"
}
