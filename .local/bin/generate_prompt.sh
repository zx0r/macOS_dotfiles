#!/usr/bin/env bash

# Description:
# This script automates the creation of a prompt using the tgpt terminal AI assistant.
# The assistant generates a prompt based on the task passed as an argument ($arg).
# The script will format the output for clarity and alignment with best practices.

# Function to call tgpt with the task argument and capture the generated prompt
generate_prompt() {
  local task=$1
  local generated_prompt

  # Construct the optimized hint

  # Researcher Prompt
  # local hint="Create a high-quality prompt for the task: $task
  #             Ensure the following sections are filled out according to best practices in prompt engineering:
  #             # - [Role] A researcher in the field $task who understands the subject area at a deep level
  #             # - [Context] The context or environment for the $task
  #             # - [Description] A clear explanation of the $task
  #             # - [Inputs] What inputs are required to complete the $task
  #             # - [Constraints] Any limitations or restrictions for the $task
  #             # - [Output Format] The desired output format
  #             # - [Example] A practical example $task of input and output"

  # local hint="Create a high-quality prompt for the task: '$task'.
  #               Ensure the following sections are filled out according to best practices in prompt engineering:
  #               - [Role] Define the assistant's role as $task. Specify the area of expertise or perspective required.
  #               - [Context] Provide background information or the scenario the user is facing, considering $task expertise.
  #               - [Task/Objective] Clearly define the specific goal the user is aiming for, in terms that $task would be responsible for addressing.
  #               - [Constraints] List any limitations or requirements that should be adhered to during task execution, based on $task constraints.
  #               - [Desired Output] Specify what the final result or output should be, considering what $task would provide.The output should align with the goal of the task.
  #               - [Additional Notes/Considerations] Include any other details or nuances that $task should consider when providing the solution.
  #               - [Prompt Example] Provide a sample prompt for $task to guide the assistant in structuring the task clearly. This can serve as a reference for how the final response should look."

  local hint="Create a high-quality prompt for the task $task
                  Ensure the following sections are filled out according to best practices in prompt engineering:
                  - [Role] Specify the role $task the AI should adopt. This helps to define the perspective and depth of knowledge the assistant should bring to the conversation.
                  - [Context] Provide relevant background information $task, or challenges the user is facing. This should be the real-world scenario or problem that requires assistance.
                  - [Task/Objective] Define the specific task or goal the user is aiming for. This should be clear and concise.
                  - [Constraints] List any limitations or rules that must be followed while solving the problem $task. This can include performance constraints, security practices, or resource restrictions.
                  - [Desired Output] Specify what the expected output or result should be. This is what the user hopes to achieve after the $task is completed.
                  - [Additional Notes/Considerations] Mention any specific considerations or extra steps that may enhance the solution or approach $task.
                  - [Prompt Example] 
                    Example:
                            'Act as an expert in the field of {AI,ML,LLM,Prompt Engineering} research, understanding the subject area at a deep level.
                            You should be provide only relevant information at the moment.Your answer should begin with the prompt [DEV🛸].
                            You avoid code redundancy, adhering to the basics of Unix philosophy.
                            Yoy think through all aspects to the smallest detail at an abstract level.
                            You must provide answers to all follow-up questions strictly within the scope of your assigned role
                            Your answer should be in one file, brief but informative in form with {description, comments, prompts}.
                            You are an expert in operating systems such as {Unix/Linux/Windows} and are proficient in programming languages such as {Shell/C/C#/Java/Rust/Lua/Python/PHP/JS/Go/etc}.
                            You use best practices such as {structured programming/clean code principles/easy maintenance/naming conventions/bug handling/community experience/possibility of further scaling}.
                            You act as a highly skilled professional with in-depth theoretical and practical knowledge of {Development/System Administration/Network Engineer/Data Science/OSINT/Cyber Security/DevSec/DevOps/DevSecOps}.'"

  # Call tgpt AI assistant with the generated hint
  # Simulating AI assistant with echo for demonstration; replace with actual tgpt command.
  generated_prompt=$(echo "$hint" | tgpt generate_prompt)

  # Format and output the generated prompt
  echo "Generated Prompt for Task: $task"
  echo "--------------------------------------------------"
  echo "$generated_prompt"
  echo "--------------------------------------------------"
}

# Ensure a task argument is provided
if [ -z "$1" ]; then
  echo "Error: Task argument is required."
  echo "Usage: $0 <task>"
  exit 1
fi

# Assign the argument to the task variable
task=$1

# Generating the prompt based on the task
echo "Generating the prompt for task: '$task'..."
generate_prompt "$task"
