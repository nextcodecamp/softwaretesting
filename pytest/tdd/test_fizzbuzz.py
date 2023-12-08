import pytest

def fizzbuzz(num):
   if (num %3 == 0 and num %5 ==0):
      return "FizzBuzz"  
   elif (num % 3 == 0):
      return "Fizz"
   elif (num %5 ==0):
      return "Buzz"
   else:
      return num
      

def test_fizzbuzz():
   assert fizzbuzz(1) == 1  
   assert fizzbuzz(2) == 2  
   assert fizzbuzz(3) == "Fizz"  
   assert fizzbuzz(4) == 4  
   assert fizzbuzz(5) == "Buzz"  
   assert fizzbuzz(6) == "Fizz"  
   assert fizzbuzz(7) == 7   
   assert fizzbuzz(8) == 8  
   assert fizzbuzz(9) == "Fizz"  
   assert fizzbuzz(14) == 14  
   assert fizzbuzz(15) == "FizzBuzz"  
   

   
   
  
   
