# BIOL 2214 Week 5 Homework

## 1. Baking a Cake

Gather flour, eggs, milk, butter, and sugar
Preheat the oven to 400 degrees Fahrenheit
Prepare an oven pan
Put the flour and sugar into a mixing bowl
Add the eggs, milk, and butter
Mix the ingredients
Pour the mixture into the oven pan
Put the pan into the oven
Bake the cake for 20 minutes
Set cake_done to False
WHILE cake_done is False
Insert a clean knife into the center of the cake
Remove the knife
    IF the knife comes out clean
        Set cake_done to True
    ELSE
        Put the cake back into the oven
        Bake the cake for 5 more minutes

## 2. Fizz Buzz

### pseudocode
FOR each number from 1 through 100
    IF the number is divisible by both 3 and 5
        Print "fizzbuzz"
    ELSE IF the number is divisible by 3
        Print "fizz"
    ELSE IF the number is divisible by 5
        Print "buzz"
    ELSE
        Print the number
        
### python program
Go through the numbers from 1 to 100, including 100.
for number in range(1, 100):
    if number % 3 == 0 and number % 5 == 0:
        print("fizzbuzz")
    elif number % 3 == 0:
        print("fizz")
    elif number % 5 == 0:
        print("buzz")
    else:
        print(number)
        