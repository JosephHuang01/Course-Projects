# Jared Cambridge
# jcambridge3@student.gsu.edu
# Mya Harding
# kharding4@student.gsu.edu
# Joseph Huang
# jhuang31@student.gdu.edu

def MatchingPasswords(password):
    if len(password) < 10 or len(password) > 100:
        return False

    if len(set(password)) < 5:
        return False

    lowercaseCount = sum(1 for char in password if char.islower())
    uppercaseCount = sum(1 for char in password if char.isupper())
    specialCount = sum(1 for char in password if char in ['~', '!', '@', '#', '$', '%', '^', '*', '-', '_', '=', '+', '[', ']', '{', '}', '/', ';', ':', ',', '.', '?'])
    
    if lowercaseCount < 1 or uppercaseCount < 1 or specialCount < 1:
        return False
    
    return True

def main():
    while True:
        password = input("Enter a password: ")
        
        if MatchingPasswords(password):
            ConfirmedPassword = input("Please re-enter the password: ")
            
            if password == ConfirmedPassword:
                print("Logging in...")
                break
            else:
                print("Passwords do not match. Try again.")
        else:
            print("Invalid password. Try again.")
            
main()