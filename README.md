This program written in assembly can be used to evaluate a mathematical prefix expression in a string.

assemblyOptions = -g -f elf32 -o math_expression_evaluator.o math_expression_evaluator.asm
linkingOptions = math_expression_evaluator.o macro.o -g -o math_expression_evaluator -m32
