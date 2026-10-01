# Jared Cambridge
# jcambridge3@student.gsu.edu
# Mya Harding
# kharding4@student.gsu.edu
# Joseph Huang
# jhuang31@student.gdu.edu

principal = float(input("Enter loan amount:"))
annualInterestRate = float(input("Enter annual interest rate:"))

monthlyInterestRate = (annualInterestRate / 100) / 12

monthlyInterestAmount = principal * monthlyInterestRate
print("The monthly interest amount is:", int(monthlyInterestAmount * 100) / 100)