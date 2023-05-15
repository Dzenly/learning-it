# Simple Command

Набор опциональных присваиваний переменных + blank separated words and ??redirections
and terminated aby a ??control operator.

Return value is its exit status (or 128 + signal number, if terminated by a signal).


# Pipeline

commands separated by | or |&.

# Lists

Sequence of pipelines.

# Compound commands

(commands) - in subshell.

{list;} - in current shell, must be terminated by semicolon or newline. Group command.

(()) - арифметические расчеты

[[]] conditional expression.

# Coprocess

coproc command

Асинхронно в subshell с установкой двустороннего pipeline.

# Shell function definition

