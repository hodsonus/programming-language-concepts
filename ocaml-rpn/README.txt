John Hodson
University of Florida
COP4020 - Programming Language Concepts
Professor Alin Dobra
RPN Calculator

This program was developed on MacOS and the command chains that are listed below are a reflection of that.

My program can be run from the following command chain:
clear && ocaml rpn.ml
This will open up a continuous streaming input and you will be able to terminate the program with either ctrl+c or by inputting the letter 'q'.


Alternatively, you can run the program from my input file test.txt with the following command chain:
clear && ocaml rpn.ml < test.txt
This will run the test.txt file through the rpn.ml file and output to the console. Note that this file is terminated with the single letter 'q', as providing this letter tells the program that the stream has finished.


My error handling is handeled through sum types, and three possible errors can be printed to the console. These are as follows:
    - "Expression contains an invalid token."                   -> Occurs when an invalid token is contained within the expression.
                                                                    - Valid tokens are:
                                                                        - Operands: any float or integer
                                                                        - Operators: "+", "-", "*", "/", "^"
    - "Invalid RPN expression, not enough operands."            -> Occurs when there are too many operators and not enough operands.
    - "Invalid RPN expression, too many elements on the stack." -> Occurs when there are too many operands and not enough operators.

The arguments should be space delimited, with no leading or trailing spaces.