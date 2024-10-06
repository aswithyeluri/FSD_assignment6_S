# Grammar rules
grammar = {
    "S": ["TL"],
    "T": ["int", "flat"],
    "L": ["L.id", "id"]
}

# Parse table
parse_table = {
    "S": {"int": ["T", "L"]},
    "T": {"int": ["int"], "flat": ["flat"]},
    "L": {"id": ["id", "L'"]},
    "L'": {"id": ["L.id", "L'"], ";": ["ε"]},
}

def shift_reduce_parser(input_string):
    stack = ["$", "S"]  # Initialize stack with end marker and start symbol
    input_string += "$"  # Add end marker to the input
    index = 0  # Index for traversing the input string
    
    output_table = []  # Table to store parsing steps
    
    while len(stack) > 0:
        current_symbol = stack[-1]
        lookahead = input_string[index]
        
        output_table.append((current_symbol, lookahead, " ".join(stack)))
        
        if current_symbol in grammar:
            if lookahead in parse_table[current_symbol]:
                stack.pop()
                production = parse_table[current_symbol][lookahead]  # Get production from parse table
                for symbol in reversed(production):
                    if symbol != "ε":
                        stack.append(symbol)
            else:
                print("Error: Invalid input")
                return False
        elif current_symbol == lookahead:
            if current_symbol == "$":
                print("Parsing complete.")
                print_output_table(output_table)
                return True
            stack.pop()
            index += 1
        else:
            print("Error: Invalid input")
            return False
    
    print("Error: Invalid input")
    return False

def print_output_table(output_table):
    print("\nParsing Steps:")
    print("Symbol\tLookahead\tStack")
    print("-----------------------------")
    for step in output_table:
        print(f"{step[0]}\t{step[1]}\t\t{step[2]}")

# Test the parser
input_string = "int id,id;"
shift_reduce_parser(input_string)
