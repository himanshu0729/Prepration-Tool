#!/bin/bash

# Function to create a directory
makeDirectory() {
    dir_name="$1"
    if [ -z "$dir_name" ]; then
        echo "Error: No directory name provided."
        exit 1
    fi

    if [ -d "$dir_name" ]; then
        echo "Directory '$dir_name' already exists."
    else
        mkdir "$dir_name"
        echo "Directory '$dir_name' created successfully."
    fi
}

# Function to delete a directory
deleteDirectory() {
    dir_name="$1"
    if [ -z "$dir_name" ]; then
        echo "Error: No directory name provided."
        exit 1
    fi

    if [ -d "$dir_name" ]; then
        rm -r "$dir_name"
        echo "Directory '$dir_name' deleted successfully."
    else
        echo "Directory '$dir_name' does not exist."
    fi
}

# Main script logic
#if [ $# -lt 2 ]; then
#    echo "Usage: $0 <functionName> <directoryName>"
#    exit 1
#fi

# TO DO:- Add git utility

# Function to initialize a Git repository in the current directory
startDSA() {
    if [ -d ".git" ]; then
        echo "Git repository already initialized in this directory."
    else
        git init
        touch README.md
        git add .
        git commit -m "Initial commit"
        echo "Git repository initialized successfully."
    fi
}

# Function to start a problem in given topic directory
startProblem() {
    topic="$1"
    question="$2"

    if [ -z "$topic" ] || [ -z "$question" ]; then
        echo "Error: Both topic and question name are required."
        echo "Usage: ./placeTool.sh startProblem <Topic> <QuestionName>"
        exit 1
    fi

    # Create topic directory if not exists
    if [ ! -d "$topic" ]; then
        mkdir "$topic"
        echo "Directory '$topic' created."
    fi

    file_path="$topic/$question.cpp"

    if [ -f "$file_path" ]; then
        echo "File '$file_path' already exists."
    else
        cat <<EOL > "$file_path"
#include<bits/stdc++.h>
using namespace std;

int main() {
    // Write your code here

    return 0;
}
EOL
        echo "Problem file '$file_path' created with basic C++ template."
    fi
}

# commitProblem
commitProblem() {
    topic="$1"
    problem="$2"
    if [ -z "$topic" ] || [ -z "$problem" ]; then
        echo "Error: Topic or Problem name not provided."
        exit 1
    fi

    file_path="$topic/$problem.cpp"
    if [ ! -f "$file_path" ]; then
        echo "Error: File '$file_path' does not exist."
        exit 1
    fi

    git add "$file_path"
    git commit -m "Solved $problem"
    echo "Committed '$file_path' with message: Solved $problem"
}

# Function to push a committed problem file
pushProblem() {
    topic="$1"
    problem="$2"
    remote="${3:-origin}"   # Use 'origin' if not provided
    branch="${4:-main}"     # Use 'main' if not provided

    if [ -z "$topic" ] || [ -z "$problem" ]; then
        echo "Error: Topic or Problem name not provided."
        exit 1
    fi

    file_path="$topic/$problem.cpp"
    if [ ! -f "$file_path" ]; then
        echo "Error: File '$file_path' does not exist."
        exit 1
    fi

    git push "$remote" "$branch"
    echo "Pushed changes to '$remote/$branch'."
}

func="$1"

case "$func" in
    makeDirectory)
        makeDirectory "$2"
        ;;
    deleteDirectory)
        deleteDirectory "$2"
        ;;
    startDSA)
        startDSA
        ;;
    startProblem)
    startProblem "$2" "$3"
        ;;
    commitProblem)
        commitProblem "$2" "$3"
        ;;
    pushProblem)
        pushProblem "$2" "$3" "$4" "$5"
        ;;
    *)
        echo "Unknown function: $func"
        echo "Available functions: makeDirectory"
        exit 1
        ;;
esac

