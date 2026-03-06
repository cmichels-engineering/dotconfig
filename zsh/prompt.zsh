#!/bin/sh



## Set the name of the function, foreground, and background color
# POWERLEVEL9K_CUSTOM_PULUMI_STACK="zsh_pulumi_stack"
# POWERLEVEL9K_CUSTOM_PULUMI_STACK_FOREGROUND="black"
# POWERLEVEL9K_CUSTOM_PULUMI_STACK_BACKGROUND="221"
# POWERLEVEL9K_CUSTOM_PULUMI_PROJECT="zsh_pulumi_project"
# POWERLEVEL9K_CUSTOM_PULUMI_PROJECT_FOREGROUND="white"
# POWERLEVEL9K_CUSTOM_PULUMI_PROJECT_BACKGROUND="056"

## zsh_pulumi_stack and zsh_pulumi_project are custom additions for PowerLevel9K that checks whether the current directory 
## contains a Pulumi.yaml file. If the file exists, you're likely working on a Pulumi project and so it adds an element to 
## the prompt showing the current project and the name of the stack.
# zsh_pulumi_stack(){
#   if test -f "Pulumi.yaml"; then
#     local stackname=$(pulumi stack | grep "Current stack is" | sed 's/://g' | sed 's/Current stack is//g')
#     echo -n "Stack:$stackname"
#   fi
# }
# 
# zsh_pulumi_project(){
#   if test -f "Pulumi.yaml"; then
#     local line=$(pulumi stack | grep "More information at")
#     local project=$(cut -d'/' -f5 <<< $line)
#     echo -n "Project: ${project}"
#   fi
# }

## To display the elements, add custom_pulumi_project and/or custom_pulumi_stack
## to the PROMPT_ELEMENTS
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(... custom_pulumi_project custom_pulumi_stack ...)

