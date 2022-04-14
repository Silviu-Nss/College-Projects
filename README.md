Assembly program used to evaluate mathematical prefix expressions in strings.

assemblyOptions = -g -f elf32 -o math_expression_evaluator.o math_expression_evaluator.asm

linkingOptions = math_expression_evaluator.o macro.o -g -o math_expression_evaluator -m32
