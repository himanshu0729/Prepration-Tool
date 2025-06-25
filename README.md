# Prepration-Tool
Facilitates better preparation and confidence for placements.

steps:-

1. Clone above repository.
2. Give permission to placeTool.sh

chmod +x placeTool.sh

3. Add placeTool.sh as an alias

nano ~/.zshrc
# Add this line:
alias placeTool='/path/to/placeTool.sh'
source ~/.zshrc

Usage:- 

# Initialize DSA Git repository
bash placeTool startDSA

# Start a new problem in Array topic named FirstMissingPositive
bash placeTool startProblem Array FirstMissingPositive

# After solving, commit the problem
bash placeTool commitProblem Array FirstMissingPositive

# Push your commit to GitHub (default origin and main branch)
bash placeTool pushProblem Array FirstMissingPositive
